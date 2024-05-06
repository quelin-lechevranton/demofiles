
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

## User-defined Types

| | |
| - | - |
| `Point_t` | [`PositionVector3D`](https://root.cern.ch/doc/master/classROOT_1_1Math_1_1PositionVector3D.html) |
| `Vector_t` | [`DisplacementVector3D`](https://root.cern.ch/doc/master/classROOT_1_1Math_1_1DisplacementVector3D.html) |

## Tracks

### Trajectories [`RecoBase/Trajectory`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Trajectory.h)

| members | description |
| - | - |
| __private__ | |
| `fPositions` | `vector<Point_t>` position at each point of the trajectory |
| `fMomenta` | `vector<Vector_t>` momentum at each point of the trajectory |
| __public__ | |
| `PositionAtPoint(i)` | `fPositions[i]` |
| `MomentumVectorAtPoint(i)` | `fMomenta[i]` |
| `MomentumAtPoint(i)` | `fMomenta[i].R()`|
| `DirectionAtPoint(i)` | `fMomenta[i]/fMomenta[i].R()` |
| | |
| `Length()` | sum of the distances between adjacent points |
| `Start()` | position at the first valid point |
| `End()` | position at the last valid point |

### Track Trajectories [`RecoBase/TrackTrajectory.h)`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/TrackTrajectory.h)

### Tracks [`RecoBase/Track.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Track.h)

| members | description |
| - | - |
| __protected__ | |
| `fTraj` | `TrackTrajectory` |
| `...` | |
| __public__ | |
| `Theta(i)` | angle of the momentum vector, by default at the first valid point |
| `Phi(i)` | same |
| `ZenithAngle(i)` | same |
| `AzimuthAngle(i)` | same |
| `...` | |

## Clusters [`RecoBase/Cluster.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Cluster.h)

## PFParticles [`RecoBase/PFParticle.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/PFParticle.h)

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
