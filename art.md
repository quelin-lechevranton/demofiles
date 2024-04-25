# art, an *event-processing framework*

## InputTag

### private members

```C++
class InputTag {
    //(...)
private:
    std::string label_{};       //it.label()
    std::string instance_{};    //it.instance()
    std::string process_{};     //it.process()
};
```

### Constructor

```C++
InputTag::InputTag(string const& s)
{
    vector<string> tokens;
    boost::split(tokens, s, boost::is_any_of(":"), boost::token_compress_off);
    auto const nwords = tokens.size();
    if (nwords > 3u) {
    throw Exception(errors::Configuration,
    "An error occurred while creating an input tag.\n")
    << "The string '" << s
    << "' has more than three colon-delimited tokens.\n"
    "The supported syntax is '<module_label>:<optional instance "
    "name>:<optional process name>'.";
    }
    if (nwords > 0) {
        label_ = tokens[0];
    }
    if (nwords > 1) {
        instance_ = tokens[1];
    }
    if (nwords > 2) {
        process_ = tokens[2];
    }
}
InputTag::InputTag(char const* s) : InputTag{string{s}} {}
```

### Examples: constructor calls

```C++
InputTag("label::process")  //it.instance(): ""
InputTag("label:instance")  //it.process(): ""
InputTag("label")           //it.instance(), it.process(): ""
```

## Handles

```C++
void myModule::analyze(const art::Event& ev)
```

### `Handle` private members [`Handle.h`](https://github.com/art-framework-suite/art/blob/5b500a6a3da02ea31220de988066822aac804ff9/art/Framework/Principal/Handle.h#L97)

```C++
template <typename T>
class art::Handle {
public:
    //(...)
    bool isValid();     //something
    bool failedToGet(); //something
private:
    T const* prod_{nullptr};                                  //h.product()
    cet::exempt_ptr<Group> group_{nullptr};                   //h.prductGetter(): group_.get()
    Provenance prov_{};                                       //*h.provenance()
    std::shared_ptr<art::Exception const> whyFailed_{nullptr};//h.failedToGet: whyFailed_.get()
};
```

### `ValidHandle` private members [``Handle.h``](https://github.com/art-framework-suite/art/blob/5b500a6a3da02ea31220de988066822aac804ff9/art/Framework/Principal/Handle.h#L287)

```C++
class art::ValidHandle {
public:
    //(...)
    bool isValid() {return true;}
    bool failedToGet() {return false;}
private:
    T const* prod_;                         //vh.product()
    EDProductGetter const* productGetter_;  //vh.productGetter()
    Provenance prov_;                       //*vh.provenance()
};
```

### `ev.getValidHandle` herited [``ProductRetriever.h``](https://github.com/art-framework-suite/art/blob/5b500a6a3da02ea31220de988066822aac804ff9/art/Framework/Principal/ProductRetriever.h#L266)

```C++
template <typename PROD>
ValidHandle<PROD>
ProductRetriever::getValidHandle(InputTag const& tag) const
{
    auto h = getHandle<PROD>(tag);
    return ValidHandle{h.product(), h.productGetter(), *h.provenance()};
}
```

### `ev.getHandle` herited [``ProductRetriever.h``](https://github.com/art-framework-suite/art/blob/5b500a6a3da02ea31220de988066822aac804ff9/art/Framework/Principal/ProductRetriever.h#L250)

```C++
template <typename PROD>
Handle<PROD>
ProductRetriever::getHandle(InputTag const& tag) const
{
auto qr = getByLabel_(WrappedTypeID::make<PROD>(), tag);
return Handle<PROD>{qr};
}
```

#### `getByLabel_` herited [``ProductRetriever.h``](https://github.com/art-framework-suite/art/blob/5b500a6a3da02ea31220de988066822aac804ff9/art/Framework/Principal/ProductRetriever.cc#L201)

```C++
GroupQueryResult
ProductRetriever::getByLabel_(WrappedTypeID const& wrapped,
                            InputTag const& tag) const
{
std::lock_guard lock{mutex_};
ProcessTag const processTag{tag.process(), md_.processName()};
ProductInfo const pinfo{ProductInfo::ConsumableType::Product,
                        wrapped.product_type,
                        tag.label(),
                        tag.instance(),
                        processTag};
ConsumesInfo::instance()->validateConsumedProduct(branchType_, md_, pinfo);
GroupQueryResult qr = principal_.getByLabel(
    mc_, wrapped, tag.label(), tag.instance(), processTag);
bool const ok = qr.succeeded() && !qr.failed();
if (recordParents_ && ok) {
    recordAsParent_(qr.result());
}
return qr;
}
```

#### Constructor: `Handle(GroupQueryResult)` [``Handle.h``](https://github.com/art-framework-suite/art/blob/develop/art/Framework/Principal/Handle.h#L142)

```C++
template <class T>
art::Handle<T>::Handle(GroupQueryResult const& gqr)
  : group_{gqr.result()}, prov_{group_}, whyFailed_{gqr.whyFailed()}
{
  if (gqr.succeeded()) {
    auto const wrapperPtr = dynamic_cast<Wrapper<T> const*>(
      gqr.result()->uniqueProduct(TypeID{typeid(Wrapper<T>)}));
    if (wrapperPtr != nullptr) {
      prod_ = wrapperPtr->product();
    } else {
      Exception e{errors::LogicError};
      e << "Product retrieval via Handle<T> succeeded for product:\n"
        << prov_.productDescription()
        << "but an attempt to interpret it as an object of type '"
        << cet::demangle_symbol(typeid(T).name()) << "' failed.\n";
      whyFailed_ = std::make_shared<art::Exception const>(std::move(e));
    }
  }
}
```

### `ev.getByLabel` herited [`ProductRetriever.h](https://github.com/art-framework-suite/art/blob/5b500a6a3da02ea31220de988066822aac804ff9/art/Framework/Principal/ProductRetriever.h#L442)

```C++
template <typename PROD>
bool
ProductRetriever::getByLabel(
    std::string const& moduleLabel,
    std::string const& instance,
    Handle<PROD>& result) const
{
result = getHandle<PROD>({moduleLabel, instance});
return static_cast<bool>(result);
}
```

```C++
template <typename PROD>
bool
ProductRetriever::getByLabel(InputTag const& tag, Handle<PROD>& result) const
{
result = getHandle<PROD>(tag);
return static_cast<bool>(result);
}
```

### Example

```C++
void myModule::analyzer(const art::Event& ev) {
    // art::InputTag myTag("label:instance");
    string myLabel="label";
    string myInstance="instance";
    art::Handle<vector<myType>> myHandle;
    ev.getByLabel(myLabel,myInstance,myHandle);
    if (myHandle.isValid()) {
        for (myType myObj : *myHandle) {
            /* analysis */
        }
    }
}
```

```C++
void myModule::analyzer(const art::Event& ev) {
    art::InputTag myTag("label:instance");
    art::ValidHandle<vector<myType>> myValidHandle=ev.getValidHandle(myTag);
    for (size_t i=0; i<myValidHandle->size(); i++) {
        myType myObj = myValidHandle->at(i);
        /* analysis */
    }
}
```
