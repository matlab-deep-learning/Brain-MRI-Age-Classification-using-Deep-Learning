Derivatives

fMRI Prep
sub-[]_task-pixar_run-001_swrf_bold.nii.gz
BOLD images collected during movie viewing. FMRI data were analyzed using SPM8 (http://www.fil.ion.ucl.ac.uk/spm) and custom software written in Matlab. Functional images were registered to the first image of the run; that image was registered to each participant’s anatomical image, and each participant’s anatomical image was normalized to the Montreal Neurological Institute (MNI) template. Registration of each individual’s brain to the MNI template was visually inspected, including checking the match of the cortical envelope and internal features like the AC-PC and major sulci. All data were smoothed using a Gaussian filter (5mm kernel).

As participants were initially recruited for different studies, there are small differences in voxel size and slice gaps across participants (3.13 mm isotropic with no slice gap (n=5 adults, n=3 7yos, n=20 8-12yo); 3.13 mm isotropic with 10% slice gap (n=28 adults), 3 mm isotropic with 20% slice gap (n=1 3yo, n=3 4yo, n=2 7yo, n=1 9yo); 3 mm isotropic with 10% slice gap (all remaining participants)); all functional data were subsequently upsampled in normalized space to 2mm isotropic voxels. 

IPS = 168 TRs; 1 TR = 2s
TR 1-5: Rest (black screen)
TR 6-10: Pixar and Disney logos
TR 11-end: Movie

sub-[]_normed_anat.nii.gz
Individual subject anatomical image, normalized to the Montreal Neurological Institute (MNI) template.

sub-[]_analysis_mask.nii.gz
Individual subject skull-stripped whole-brain mask. 

sub-[]_CompCor_mask.nii.gz
Individual subject white matter mask, normalized in MNI space, and eroded by two voxels in every direction (in order to avoid partial voluming with grey matter). This white matter mask was used for creation of CompCor regressors.

sub-[]_task-pixar_run-001_ART_and_CompCor_nuisance_regressors.mat
Individual subject artifact timepoint regressors and CompCor regressors. 

Artifact timepoint regressors were created using the Artifact Detection Tool (ART; https://www.nitrc.org/projects/artifact_detect/) as timepoints for which there was 1) more than 2mm composite motion relative to the previous timepoint or 2) a fluctuation in global signal that exceeded a threshold of three standard deviations from the mean global signal. 

Compcor regressors are 5 principle component analysis (PCA)-based noise regressors generated using CompCor within individual subject eroded white matter masks. CompCor regressors were defined using scrubbed data (e.g. artifact timepoints were identified and interpolated over prior to running CompCor). 



ROIs (Regions of Interest)
Center coordinates are in MNI space; size is in voxels. 

ToM Network 
RTPJ_9mm_sphere_xyz.mat (center: 48,-60,30; size: 376)
LTPJ_9mm_sphere_xyz.mat (center: -48,-62,30; size: 368)
PC_9mm_sphere_xyz.mat (center: 0,-54,34; size: 382)
DMPFC_9mm_sphere_xyz.mat (center: -6,54,36; size: 217)
MMPFC_9mm_sphere_xyz.mat (center: -4,58,16; size: 275)
VMPFC_9mm_sphere_xyz.mat (center: -4,56,-16; size: 198)

Pain Matrix
RS2_9mm_sphere_xyz.mat (center: 60,-28,38; size: 368)
LS2_9mm_sphere_xyz.mat (center: -62,-32,34; size: 269)
RInsula_9mm_sphere_xyz.mat (center: 42,6,-6; size: 309)
LInsula_9mm_sphere_xyz.mat (center: -42,-2,-4; size: 240)
RMFG_9mm_sphere_xyz.mat (center: 50,42,12; size: 142)
LMFG_9mm_sphere_xyz.mat (center: -46,36,14; size: 256)
AMCC_9mm_sphere_xyz.mat (center: 0,2,42; size: 249)

Face Network
rSTS_masked.mat
lSTS.mat
rOFA.mat
lOFA.mat
rFFA.mat
lFFA.mat   

Place Network
rRSC.mat                  
lRSC.mat
rTOS.mat
lTOS.mat
rPPA.mat                  
lPPA.mat

Primary motor cortex
right_primotor.mat
left_primotor.mat

Primary visual cortex
right_CS.mat                      
left_CS.mat


ToM and pain matrix group ROIs were created in an independent group of adults (n=20), scanned by Evelina Fedorenko and colleagues. These data were preprocessed and analyzed with procedures identical to those used for participants in the current study. Reverse correlation analyses were conducted in this separate group of adults, using 10mm group ROIs surrounding peaks reported in previous publications (ToM regions: Dufour et al., 2013; Pain matrix: Bruneau et al., 2015). Seven ToM and nine pain events were identified (ToM: 60s total, M(SD) length: 8.6(4.6)s, Pain: 66s total, M(SD) length: 7.3(4.4)s). We subsequently used a general-linear model to analyze BOLD activity of these participants as a function of condition, using these events. Second-level random effects analyses were used to examine the group-level response to Mental > Pain and Pain> Mental (p<.001, k=10, uncorrected). We then drew 9mm spheres surrounding the peak activation in each region.

Face and scene parcels are publicly available (http://web.mit.edu/bcs/nklab/GSS.shtml), and described in:
Julian, J. B., Fedorenko, E., Webster, J. & Kanwisher, N. An algorithmic method for functionally defining regions of interest in the ventral visual pathway. NeuroImage 60, 2357–2364 (2012).

Primary motor and visual cortex ROIs are 10mm spheres drawn around peak coordinates generated with Neurosynth (http://neurosynth.org/; M1: search term: “primary motor,” coordinates: [38,-24,58], [-38,-20,58]; V1: search term: “primary visual,” coordinates: [-10 -86 2], [10 -86 2]. 

