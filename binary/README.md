# Downloading HypoTrace
To use HypoTrace on your computer, please download and install MATLAB run time library for either [Windows](http://de.iplantcollaborative.org/dl/d/B5369782-4C6C-464E-A7EF-48680C92DD6B/MCRInstaller.exe) or [Mac](http://de.iplantcollaborative.org/dl/d/2E76512A-B7D9-4723-B82D-7EE8C16BE0A2/MATLAB_Component_Runtime.dmg). 
## There are three versions of HypoTrace available for downloading.
1. [Windows](binary/HYPOTrace-PC.zip) version
2. [Mac (Intel Processor)](binary/HYPOTrace-MAC.zip) version
3. [Mac (PowerPC)](binary/HYPOTrace-MAC-PowerPC.zip
) version
## Details
HypoTrace automatically extracts growth and shape information from electronic gray-scale images of Arabidopsis (Arabidopsis thaliana) seedlings. Key to the method is the iterative application of adaptive local principal components analysis to extract a set of ordered midline points (medial axis) from images of the seedling Hypocotyl. Pixel intensity is weighted to avoid the medial axis being diverted by the cotyledons in areas where the two come in contact. An intensity feature useful for terminating the midline at the Hypocotyl apex was isolated in each image by subtracting the baseline with a robust local regression algorithm. Applying the algorithm to time series of images of Arabidopsis seedlings responding to light resulted in automatic quantification of Hypocotyl growth rate, apical hook opening, and phototropic bending with high spatiotemporal resolution.

## System requirements
HypoTrace has been tested on both Windows and UNIX (both Intel processor and PowerPC). 

## Related References
Wang, L, Uilecan, IV, Assadi, AH, Kozmik, CA, Spalding, EP (2009). HYPOTrace: image analysis software for measuring hypocotyl growth and shape demonstrated on Arabidopsis seedlings undergoing photomorphogenesis. [Plant Physiology 10.1104/pp.108.134072](http://www.plantphysiol.org/content/149/4/1632.full)

Wang, L, Assadi, AH, Spalding, EP (2008). Tracing branched curvilinear structures with a novel adaptive local PCA algorithm. In [Proc. Int'l Conf. on Image Processing, Computer Vision, & Pattern Recognition (IPCV), Vol. 2, pp. 557-563](binary/IPCV08_Wang_et_al.pdf)
