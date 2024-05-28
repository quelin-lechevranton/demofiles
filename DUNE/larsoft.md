# LArSoft: *liquid argon software*

## Generation

| PDVD | |
| - | - |
| x | `-340->340` |
| y | `-337->337` |
| z | `0->200` |
| θxz | `atan(Px/Pz)` : `180->360` |
| θyz | `atan(Py/PTy)=acos(Py/P)` : `-90->90` |

## Module

bla_module.cc using EDAnalyzer.h

blabla.fcl

compilation avec mrb

run avec lar -c blabla.fcl

```bash
fhicl-dump --help
lar --print-available module
lar --prin-description "modulename"
nohup lar ?? >&amp; pg.out
pgrep lar
```

```C++
Constructor (fhicl::ParameterSet const & fcl) {
    type_t x = p.get<type_t>("parameterNameInFhicl",x_default);
}
// if the parameter is a sequence: type_t = vector<...>
// if the parameter is a table: type_t = struct {...}
```

## GeoTypes [geo_vectors.h](https://github.com/LArSoft/larcoreobj/blob/develop/larcoreobj/SimpleTypesAndConstants/geo_vectors.h)

| typename | description |
| - | - |
| `geo::Length_t` | `double` |
| `geo::Point_t` | [`PositionVector3D`](https://root.cern.ch/doc/master/classROOT_1_1Math_1_1PositionVector3D.html) |
| `geo::Vector_t` | [`DisplacementVector3D`](https://root.cern.ch/doc/master/classROOT_1_1Math_1_1DisplacementVector3D.html) |

## Data products [cf. practical guide](https://indico.fnal.gov/event/20453/contributions/57771/attachments/36174/44057/larsofttutorial1.pdf)

| object | description |
| - | - |
| `simb::MCTruth` | information about the generation (before G4) |
| `simb::MCParticle` | all particle information: one instance by `MC::Truth` then one by G4 |
| `sim::SimEnergyDeposit` | G4 |

| object | description |
| - | - |
| `raw::Digit` | ADC count wrt time ticks on one channel |

| object | description |
| - | - |
| `recob::Wire` | deconvolved signal of `Digit` |
| `recob::Hit` | gaussian fit on `Wire` |
| `recob::Cluster` | `Hit` coincidence on multiple wires of one plane |
| `recob::SpacePoint` | `Cluster` coincidence on all three planes |
| `recob::PFParticle` | collection of `Cluster` produced by one reconstructed particle |
| `recob::Track` | track reconstruction on appropriate hits from a track-like `PFParticle` |
| `anab::Calorimetry` | calorimetric measurement for each plane and each `Track` |
| `recob::Shower` | shower reconstruction on hits from a shower-like `PFParticle` |

## Truth & Particles

### Trajectory [`SimulationBase/MCTtrajectory.h`](https://github.com/NuSoftHEP/nusimdata/blob/develop/nusimdata/SimulationBase/MCTrajectory.h)

| members | description |
| - | - |
| __private__ | |
| `ftrajectory` | `vector<pair<TLorentzVector, TLorentzVector>>` |
| __public__ | |
| `Position(i)` | `ftrajectory[i].first` |
| `Momentum(i)` | `ftrajectory[i].second` |
| `TotalLength()` | `(double)` sum of the distances between adjacent positions |

### Particle [`SimulationBase/MCParticle.h`](https://github.com/NuSoftHEP/nusimdata/blob/develop/nusimdata/SimulationBase/MCParticle.h)

| members | description |
| - | - |
| __private__ | |
| `fpdgCode` | `int` |
| `ftrajectory` | `simb::MCTrajectory` |
| `fdaughters` | `set<int>` |
| __public__ | |
| `PdgCode()` | `fpdgCode` |
| `Position(i)` | `ftrajectory.Position(i)` |
| `Momentum(i)` | `ftrajectory.Momentum(i)` |
| `Daugther(i)` | `i`-th daughter's ID |

### Truth [`SimulationBase/MCTruth.h`](https://github.com/NuSoftHEP/nusimdata/blob/develop/nusimdata/SimulationBase/MCTruth.h)

| members | description |
| - | - |
| __private__ | |
| `fPartList` | `vector<simb::MCParticle>` |
| __public__ | |
| `GetParticle(i)` | `fPartList[i]` |
| `GetNeutrino(i)` | `fMCNeutrino` |

## SimEnergyDeposits [`Simulation/SimEnergyDeposit.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/Simulation/SimEnergyDeposit.h)

| members | description |
| - | - |
| __private__ | |
| `trackID` | same as `origTrackID`: track ID of the generated particle at the origine of the deposited energy |
| __public__ | |
| `GetParticle(i)` | `fPartList[i]` |
| `GetNeutrino(i)` | `fMCNeutrino` |

## Clusters [`RecoBase/Cluster.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Cluster.h)

## PFParticles [`RecoBase/PFParticle.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/PFParticle.h)

## Tracks

### User-defined Types [`RecoBase/TrackingTypes.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/TrackingTypes.h)

| typename | description |
| - | - |
| `Point_t` | [`PositionVector3D`](https://root.cern.ch/doc/master/classROOT_1_1Math_1_1PositionVector3D.html) |
| `Vector_t` | [`DisplacementVector3D`](https://root.cern.ch/doc/master/classROOT_1_1Math_1_1DisplacementVector3D.html) |
| `TrajectoryPoint_t` | `struct {P_t p; V_t m; V_t direction() return m.Unit();}` |

### Trajectories [`RecoBase/Trajectory.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Trajectory.h)

| members | description |
| - | - |
| __private__ | |
| `fPositions` | `vector<Point_t>` position at each point of the trajectory |
| `fMomenta` | `vector<Vector_t>` momentum at each point of the trajectory |
| __public__ | |
| `LocationAtPoint(i)` | `fPositions[i]` |
| `MomentumVectorAtPoint(i)` | `fMomenta[i]` |
| `MomentumAtPoint(i)` | `fMomenta[i].R()`|
| `DirectionAtPoint(i)` | `fMomenta[i]/fMomenta[i].R()` |
| `TrajectoryPoint(i)` | `(TrajectoryPoint_t) {fPositions[i],fMomenta[i]}` |
| | |
| `Length()` | sum of the distances between adjacent points |
| `Start()` | position at the first valid point |
| `End()` | position at the last valid point (track ends can be mixmatched) |

### Track Trajectories [`RecoBase/TrackTrajectory.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/TrackTrajectory.h)

`class TrackTrajectory : private recob::Trajectory {...};`

### Tracks [`RecoBase/Track.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Track.h)

| members | description |
| - | - |
| __protected__ | |
| `fTraj` | `TrackTrajectory` |
| `...` | |
| __public__ | |
| `LocationAtPoint(i)` | `fTraj.LocationAtPoint(i)` |
| `Start()` | `fTraj.Start()` |
| `...` | |

## Calorimetry [`AnalysisBase/Calorimetry.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/AnalysisBase/Calorimetry.h)

## Showers [`RecoBase/Shower.h`](https://github.com/LArSoft/lardataobj/blob/develop/lardataobj/RecoBase/Shower.h)

## Truth Reco Associations

```C++
art::ServiceHandle<cheat::BackTrackerService> bt_serv;
art::ServiceHandle<cheat::ParticleInventoryService> pi_serv;


auto const clockData = art::ServiceHandle<detinfo::DetectorClocksService>()->DataFor(evt);
```

### [`protoduneana/Utilities/`](https://github.com/DUNE/protoduneana/blob/develop/protoduneana/Utilities)

## Truth Object Associations

```C++

```

## Reco Object Associations

### [`FindManyP`](https://code-doc.larsoft.org/docs/latest/html/FindManyP_8h_source.html)

```C++
using namespace std;
using namespace art;
using namespace recob;

ValidHandle<vector<PFP>> const vh_pfp = evt.getValidHandle<vector<PFP>>(tag_pfp);
vector<Ptr<PFP>> vp_pfp;
fill_ptr_vector(vp_pfp,vh_pfp);

FindManyP<Track> const fmp_track(vp_pfp,evt,label_track);
FindManyP<SpacePoint> const fmp_point(vp_pfp,evt,label_point);

for (Ptr<PFP> const & p_pfp : vp_pfp) {
    vector<Ptr<Track>> vp_track = fmp_track.at(p_pfp.key());

    if(vp_track.empty()) {
        /* */
    }
    else {
        Ptr<Track> p_track = vp_track[0];
        /* */
    }

    vector<Ptr<SpacePoint>> vp_point = fmp_point.at(p_pfp.key());
    for (Ptr<SpacePoint> const & p_point : vp_point) {
        /* */
    }
}
```

### [`dunereco/AnaUtils/`](https://github.com/DUNE/dunereco/blob/develop/dunereco/AnaUtils)

```C++
namespace danaEvt=dune_ana::DUNEAnaEventUtils;
namespace danaPFP=dune_ana::DUNEAnaPFParticleUtils;

vector<Ptr<PFP>> const vp_pfp = danaEvt::GetPFParticles(evt,label_pfp);

for (Ptr<PFP> const & p_pfp : vp_pfp) {
    if (!danaPFP::IsTrack(p_pfp,evt,label_pfp,label_tack)) {
        /* */
    }
    else {
        Ptr<Track> const p_trk = danaPFP::GetTrack(p_pfp,evt,label_pfp,label_trk);
        /* */
    }

    vector<Ptr<SpacePoint>> const vp_point = danaPFP::GetSpacePoints(p_pfp,evt,label_point);
    for (Ptr<SpacePoint> const & p_point : vp_point) {
        /* */
    }
}
```

### [`protoduneana/Utilities/`](https://github.com/DUNE/protoduneana/tree/develop/protoduneana/Utilities)

```C++
protoana::ProtoDUNEPFParticleUtils pfpUtils;
art::ValidHandle<vector<recob::PFParticle>> const vh_pfp = evt.getValidHandle<vector<recob::PFParticle>>(tag_pfp);

for (recob::PFParticle const & pfp : *vh_pfp) {
    if (!IsPFParticleTracklike(pfp,evt,label_pfp,label_track)) {
        /* */
    }
    else {
        const recob::Track* trk = pfpUtils.GetPFParticleTrack(pfp,evt,label_pfp,label_track);
        /* */
    }

    vector<recob::SpacePoint*> v_spt = pfpUtils.GetPFParticleSpacePoints(pfp,evt,label_pfp);
    for (recob::SpacePoint* spt : v_spt) {
        /* */
    }
}
```

## ???

```C++
art::Ptr<recob::Track> ptrack(trackListHandle, i);
const recob::Track& track = *ptrack;

const simb::MCParticle* daughter1 = pi_serv->TrackIdToParticle_P((particleP1->Daughter(i_daugther)));

art::Handle<vector<recob::Hit>> h_hit= /* ... */;
for (int i=0; i<h_hit->size(); i++) {
    art::Ptr<recob::Hit> p_hit(h_hit,i);
}

const simb::MCParticle *particleP = truthUtil.GetMCParticleFromRecoTrack(track,evt,fTrackModuleLabel);
if(!particleP) continue;
const art::Ptr<simb::MCTruth> mcP=pi_serv->TrackIdToMCTruth_P(particleP->TrackId());
if(!mcP) continue;
double distance = 99999
```

### `AnaUtils` Who Gets Who

| From | Get |
| - | - |
| `Hit` | `SpacePoints` |
| `Cluster` | `Hits` |
| `SpacePoint` | `Hits` |
| `Track` | `Hits` `SpacePoints` `PFParticle` |
| `Shower` | `Hits` `SpacePoints` `PFParticle` |
| `PFParticle` | `Hits` `SpacePoints` `Track` `Shower` `Slice` `Vertex` `ChildParticles` `...` |

## MetaCat

`metacat query "files where 025086 in core.runs and core.data_tier=raw limit 10"`

`export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune`

`export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/appi`
