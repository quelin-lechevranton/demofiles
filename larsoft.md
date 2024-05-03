
# LArSoft: *liquid argon software*

## Data products

| object | description |
| - | - |
| `simb::MCTruth` | |
| `simb::MCParticle` | |
| `sim::SimEnergyDeposit` | |

| object | description |
| - | - |
| `raw::Digit` | ADC count wrt time ticks on one channel |

| object | description |
| - | - |
| `recob::Wire` | deconvolved signal of `Digit` |
| `recob::Hit` | gaussian fit on `Wire` |
| `recob::Cluster` | `Hit` coincidence on multiple wires of one plane |
| `recob::SpacePoint` | `Cluster` coincidence on all three planes |
| `recob::PFParticle` | collection of `Cluster` produced by one particle |
| `recob::Track` | track reconstruction on appropriate hits from a track-like `PFParticle` |
| `anab::Calorimetry` | calorimetric measurement for each plane and each `Track` |
| `recob::Shower` | shower reconstruction on hits from a shower-like `PFParticle` |

### Clusters [`RecoBase/Cluster.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Cluster.h)

### PFParticles [`RecoBase/PFParticle.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/PFParticle.h)

## [`dunereco/AnaUtils`](https://github.com/DUNE/dunereco/blob/develop/dunereco/AnaUtils)

### Namespaces

```C++
std::vector
str::string
art::Event
art::Ptr
```

### Declarations [`DUNEAnaUtilsBase.h`](https://github.com/DUNE/dunereco/blob/develop/dunereco/AnaUtils/DUNEAnaUtilsBase.h#L26)

```C++
namespace dune_ana {
class DUNEAnaUtilsBase {
protected:
    template <typename T>
    static vector<Ptr<T>> GetProductVector(const Event &evt, const string &label);

    template <typename T, typename U>
    static vector<Ptr<T>> GetAssocProductVector(const Ptr<U> &part, const Event &evt, const string &label, const string &assocLabel);

    template <typename T, typename U>
    static Ptr<T> GetAssocProduct(const Ptr<U> &part, const Event &evt, const string &label, const string &assocLabel); 
};
}
```

#### Pseudo code

```C++
vector<Ptr<Hit>> hitsPtrVec = GetHits(trackPtr,ev,track_label)
//where
DUNEAnaTrackUtils::GetHits(trackPtr,ev,track_label) ==
DUNEAnaUtilsBase::GetProductVector<recob::Hit>(trackPtr,evt,track_label,track_label)
{
    vh = ev.getValidHandle<Track>(track_label);
    FindManyP<Hit> fmp(vh,ev,track_label);
    return fmp.at(trackPtr.key());
}
```

## MetaCat

`metacat query "files where 025086 in core.runs and core.data_tier=raw limit 10"`

`export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune`

`export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/appi`
