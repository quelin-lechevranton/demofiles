# ROOT: *CERN data analysis framework*

## ?

```C++
TF1 f1("f1","formula",parameters); 
TF1 *f1=new TF1("f1","formula",parameters);

R__ADD_INCLUDE_PATH("...")
ReadFileList(n_file,"path/to/file.list")
```

`TFile file("file.root")` vs `TFile* file=TFile::Open("file.root")`

`new TBrowser` vs `TBrowser b`

`.include` `.class`

## Arborescence ROOT

```C++
$ root path/to/file.root
root[] new TBrowser
root[] Events / ns::class_some_module_name / nm::class_some_module_name.obj / a / b / c
```

## Draw with ROOT

```C++
$ root
root[] TFile *_file0 = TFile::Open("path/to/file")
root[] _file0->cd()
root[] Events->GetListOfBranches()->ls()
root[] Events->Draw("ns::class_some_module_name.obj.a.b.c","...","","")
```

## Access in macro C

```C++
gallery::Event ev("path/to/file.root");
art::InputTag module_tag(some:module:name);
auto const obj_list = ev.getValidHandle<vector<ns::class>>(module_tag);
ns::class& obj = obj_list->at(index);
obj.a() #only access to the methods (leaves with a red bang ! on it, leaves with names like ...()), thoses are only seen in TBrowser if larsoft was previously set up
//how to access the other leaves ???
```

## Examples

```C++
f1.SetParameter(parameter_id,parameter_value);

Events -> GetListOfBranches() -> ls() //print list of branches in the tree Events
Events->Draw("varY:varX>>hXY(??,??,??,??,??,??)","condition","drawing_option")
Events->Draw("anab::Calorimetrys_pandoraStdcalo__Reco.obj.fdEdx:(anab::Calorimetrys_pandoraStdcalo__Reco.obj.fRange-anab::Calorimetrys_pandoraStdcalo__Reco.obj.fResidualRange)","","colZ")
Events->Draw("simb::MCParticles_largeant__G4.obj.ftrajectory.ftrajectory.first.fP.fX:simb::MCParticles_largeant__G4.obj.ftrajectory.ftrajectory.first.fP.fY>>hXY(150,-125,25,300,100,400)","simb::MCParticles_largeant__G4.obj.fpdgCode==13","")
Events->sim::SimEnergyDeposits_largeant_LArG4DetectorServicevolTPCActive_G4Stage1.obj.startPos.fCoordinates.Theta()
Events->simb::MCTruths_cosmicgenerator__SinglesGen.obj.fPartList.Py()/simb::MCTruths_cosmicgenerator__SinglesGen.obj.fPartList.P()
```

## Classes

`TF1`
`TH1F`
`TROOT`
`TUnixSystem`
`TCling`
`TTree::Draw()`

```ROOT
TNamed <- TObject .
```

```ROOT
TFile <- TDirectoryFile <- TDirectory <- TNamed
```

`TDirectory` has the methods `cd()`, `ls()` and `pwd()` that can be access with `.ls` and `.pwd` in `Cling` for the current `TDirectory`

```ROOT
TTree <- TNamed <-
      <- TAttLine .
      <- TAttFill .
      <- TAttMarker .
```

```ROOT
TBranchElement <- TBranche <- TNamed <-
               <- TAttFill .
```

## File Navigation

```C++
TFile file("file.root");
TObject* obj = file.Get("path/to/obj");
TTree* tree = file.Get<TTree>("path/to/obj");
TTree* tree = (TTree*) file.Get("path/to/obj");
```

```C++
$ root file.root
root[] _file0->cd()
(bool) true
root[] .ls //alternatively: root[] _file0->ls()
TFile**
 TFile*
  KEY: TDirectoryFile tdf;1 tdf (tdf) folder
  KEY: <rootClass> <identifier;namecycle> <identifier> <?>
  KEY: <rootClass> <identifier;namecycle> <identifier> <?>
root[] tdf->cd()
root[] .pwd //alternatively: root[] tdf->pwd()
Current directory: file.root:/tdf
Current style:     Modern
root[] .ls //alternatively: root[] tdf->ls()
TDirectoryFile* tdf;1 tdf (tdf) folder
  KEY: TTree tt;1 tt
  // (...)
root[] tt->GetListOfBranched()->ls()
OBJ: TObjArray TObjArray An array of objects : ??
 OBJ: TBranch var var : ?? at 0x4bfcef0
 OBJ: TBranch <identifier> <leaflist> : ?? at <address>
 OBJ: TBranchElement // (...)
```

```C++
TFile* file=TFile::Open("file.root");
TTree* tt= (TTree*) file->Get("tdf/tt"); //Get() returns a TObject*

tt->GetListOfBranches()->ls(); //print in stdout

type_t* var=nullptr; //pointers should always be initialized
tt->SetBranchAddress("b1",&var);
//TBranch* b1 = tt->GetBranch("b1");
//b1->SetAddress(&var);
for (int i=0; i< tt->GetEntries(); i++) {
    tt->GetEntries(i); //var is now the pointer to the value of b1 for the event #i
}

```

## `TColor`

```C++
typedef short Color_t;
enum { kWhite=0, kBlack=1, kRed=632, kGreen=416 } //and so on
// 2 also gives red
```

[RtypesCore.h](https://root.cern.ch/doc/master/RtypesCore_8h_source.html#l00092)
[Rtypes.h](https://root.cern.ch/doc/master/Rtypes_8h_source.html#l00065)
[TColor.h](https://root.cern.ch/doc/master/TColor_8h_source.html)

## Random Notes

`SetMarkerSize(size_t msize)` doesn't affect default marker size `SetMarkerStyle(20)` is needed.
