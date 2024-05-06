# art:  *FNAL event processing framework*

`echo $CANVAS_DIR`

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

- `gallery::` "version simplifié des objets art pour des macros"
- `art::` "à utiliser pour écrire un module LArSoft"

```C++
void myModule::analyze(const art::Event& ev) {
    /* my analysis */
}
```

[`Handle.h`](https://github.com/art-framework-suite/art/tree/develop/art/Framework/Principal/Handle.h)

> Handle: Non-owning "smart pointer" for reference to EDProducts and their Provenances.
>
> ValidHandle: A Handle that can not be invalid, and thus does not check for validity upon dereferencing.
>
> Handles can have:
>
> - Product and Provenance pointers both null;
> - Both pointers valid
>
> ValidHandles must have Product and Provenance pointers valid.

### `Handle` private members [`Handle.h`](https://github.com/art-framework-suite/art/tree/develop/art/Framework/Principal/Handle.h#L97)

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

### `ValidHandle` private members [``Handle.h``](https://github.com/art-framework-suite/art/tree/develop/art/Framework/Principal/Handle.h#L287)

```C++
class art::ValidHandle {
public:
    //this is a modified version for clarity
    bool isValid() {return true;}
    bool failedToGet() {return false;}

private:
    T const* prod_;                         //vh.product()
    EDProductGetter const* productGetter_;  //vh.productGetter()
    Provenance prov_;                       //*vh.provenance()
};
```

```C++
namespace art {
class Event final : private ProductRetriever {
    /*...*/
};
}
```

### `ev.getValidHandle` herited [``ProductRetriever.h``](https://github.com/art-framework-suite/art/tree/develop/art/Framework/Principal/ProductRetriever.h#L266)

```C++
template <typename PROD>
ValidHandle<PROD>
ProductRetriever::getValidHandle(InputTag const& tag) const
{
    auto h = getHandle<PROD>(tag);
    return ValidHandle{h.product(), h.productGetter(), *h.provenance()};
}
```

### `ev.getHandle` herited [``ProductRetriever.h``](https://github.com/art-framework-suite/art/tree/develop/art/Framework/Principal/ProductRetriever.h#L250)

```C++
template <typename PROD>
Handle<PROD>
ProductRetriever::getHandle(InputTag const& tag) const
{
auto qr = getByLabel_(WrappedTypeID::make<PROD>(), tag);
return Handle<PROD>{qr};
}
```

#### `getByLabel_` herited [``ProductRetriever.h``](https://github.com/art-framework-suite/art/tree/develop/art/Framework/Principal/ProductRetriever.cc#L201)

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

### `ev.getByLabel` herited [`ProductRetriever.h`](https://github.com/art-framework-suite/art/tree/develop/art/Framework/Principal/ProductRetriever.h#L442)

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

### Examples

#### in a module

```C++
void myModule::analyzer(const art::Event& ev) {
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
    for (size_t i=0; i<myValidHandle.product()->size(); i++) {
        myType myObj = myValidHandle.product()->at(i)
        //myType myObj = myValidHandle->at(i)
        //myType myObj = (*myValidHandle)[i]
        //myType myObj = myValidHandle()->at(i) (not in gallery::)
        
        /* analysis */
    }
}
```

#### in a macro

```C++
gallery::Event ev({"file.root"});
art::InputTag myTag("label:instance");
gallery::ValidHandle<vector<myType>> myValidHandle=ev.getValidHandle(myTag);
for (size_t i=0; i<myValidHandle->size(); i++) {
    myType myObj = myValidHandle->at(i);

    /* analysis */
}


## `art::FindManyP` [`???.h`](https://github.com/art-framework-suite/canvas/tree/develop/canvas/Persistency/Common)

```C++
art::FindManyP<myType> myAssoc(???,ev,myLabel);
```

[`Ptr.h`](https://github.com/art-framework-suite/canvas/blob/develop/canvas/Persistency/Common/Ptr.h)

> a Ptr is a persistent smart pointer to an item in a collection

### `GetAssocProductVector<myType>` in [`DUNEAnaUtilsBase.h`](https://github.com/DUNE/dunereco/tree/develop/dunereco/AnaUtils/DUNEAnaUtilsBase.h#L54)

```C++
template <typename T, typename U> std::vector<art::Ptr<T>> DUNEAnaUtilsBase::GetAssocProductVector(const art::Ptr<U> &pProd, const art::Event &evt, const std::string &label, const std::string &assocLabel)
{
    auto products = evt.getHandle<std::vector<U>>(label);
    bool success = products.isValid();

    if (!success)
    {
        mf::LogError("DUNEAna") << " Failed to find product with label " << label << " ... returning empty vector" << std::endl;
        return std::vector<art::Ptr<T>>();
    }

    const art::FindManyP<T> findParticleAssocs(products,evt,assocLabel);

    return findParticleAssocs.at(pProd.key());
}
```

### `GetTrack` in [`DUNEAnaPFParticleUtils.cxx`](https://github.com/DUNE/dunereco/tree/develop/dunereco/AnaUtils/DUNEAnaPFParticleUtils.cxx#L115)

```C++
art::Ptr<recob::Track> DUNEAnaPFParticleUtils::GetTrack(
    const art::Ptr<recob::PFParticle> &pParticle, 
    const art::Event &evt, const std::string &particleLabel, 
    const std::string &trackLabel
) {
    return DUNEAnaPFParticleUtils::GetAssocProduct<recob::Track>(
        pParticle,
        evt,
        particleLabel,trackLabel
    );
}
```

### Examples (without namespaces)

```C++
const vector<Ptr<PFParticle>> pfpPtrVec = GetPFParticles(ev,pfp_label);
FindManyP<Cluster> cluPfpAssoc(pfpP_vec,ev,clu_label);

for (const Ptr<PFParticle>& pfpPtr : pfpPtrVec) {

    vector<Ptr<Cluster>> cluPtrVec = cluPfpAssoc.at(pfpPtr.key());

    if (!cluPtrVec.empty()) {

        for (const Ptr<Cluster>>& cluPtr : cluPtr) {
            /*...*/
        }
    }

    if (IsTrack(pfpPtr,ev,pfp_label,track_label)) {

        Ptr<Track> trackPtr = GetTrack(pfpPtr,ev,pfp_label,track_label)

        vector<Ptr<Hits>> hitsPtrVec = GetHits(trackPtr,ev,track_label)

    }
    
}
```
