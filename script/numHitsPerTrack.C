
auto magic = fcc::MCParticleData();


auto get_pt = [](std::vector<fcc::MCParticleData> in){
 double result;
      int i = 0;
		 result = sqrt(in[i].core.p4.px * in[i].core.p4.px + in[i].core.p4.py * in[i].core.p4.py);
	 return result;
};

auto get_eta = [](std::vector<fcc::MCParticleData> in){
 float result;
   TLorentzVector lv;
   int i = 0;
     lv.SetXYZM(in[i].core.p4.px, in[i].core.p4.py, in[i].core.p4.pz, in[i].core.p4.mass);
     result = lv.Eta();
   return result;
};

auto select_hits_from_primaries = [](std::vector<fcc::PositionedTrackHitData> in){
 std::vector<fcc::PositionedTrackHitData> result;
	 for (int i = 0; i < in.size(); ++i) {
     if (in[i].core.bits == 1) {
       result.push_back(in[i]);

     }
	 }
	 return result;
};


auto collectionSize = [](std::vector<fcc::PositionedTrackHitData> in){
  float result;
  result = in.size();
	return result;
};


int numHitsPerTrack(std::string filename) {
  gROOT->SetBatch();
  ROOT::RDataFrame df("events", filename);
  auto dff = df
               .Define("GenParticles_Pt", get_pt, {"GenParticles"})
               .Filter("GenParticles_Pt > 100")
               ;
    dff = dff
               .Define("GenParticles_Eta", get_eta, {"GenParticles"})
               .Define("PrimaryHits", select_hits_from_primaries, {"TrackerPositionedHits"} )
               .Define("NumPrimaryHits", collectionSize, {"PrimaryHits"} )
               ;
  auto histo_numHits_vs_eta = dff.Histo2D({"histo_numHits_vs_eta", "Number of Hits per Track vs.  Pseudorapidity; #eta; Num Hits", 61, 0, 6, 30, -0.5, 29.5 },"GenParticles_Eta","NumPrimaryHits");
  //auto d2 = dff.Display({"GenParticles_Eta", "NumPrimaryHits"});
  //d2->Print();
  auto c = new TCanvas();
  auto profile = histo_numHits_vs_eta->ProfileX();

  profile->DrawClone("");
  c->Print("numHitsPerTrack.png");


  return 0;
  }


