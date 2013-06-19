import sys
import os
from optparse import OptionParser
from plotting import *



if __name__ == '__main__':
    no_args = len(sys.argv)
    usage = 'usage: %prog [options] map1 map2'
    parser = OptionParser(usage=usage)
    parser.add_option("--map1-name",
            default="",
            help="name for the specified first map used in the plot") 
    parser.add_option("--map2-name",  
            default="",
            help="name for the specified first map used in the plot") 
    parser.add_option("-c", "--contour-map",  
            help="map used for zero cotouring, this is need in with the t-Welch's method. Default the conour from map1 is taken")
    parser.add_option("-v", "--varmap",
            help='variation map used to determine the significance of the differences in the diffmap')
    parser.add_option("-f", "--variation-factor", 
            type="float",
            default=1.0, 
            help="factor with which the variation is multiplied when comparing to the raw differences")
    parser.add_option("--colormap", 
            default="jet", 
            help="colormap used for coloring the difference map.")
    parser.add_option("-s", "--shift180",
            action="store_true", default=False,
            help='shifts the diffmap half a unit cell in x direction, default is jet')
    (options, args) = parser.parse_args()
    no_args = len(args)
    if no_args < 2:
        parser.error("you have to specify both maps as arguments")
    diffmap1_filepath = args[0]
    diffmap2_filepath = args[1]
    if options.contour_map:
        map1_filepath = options.contour_map
    else:
        map1_filepath = diffmap1_filepath

            
    with open(map1_filepath,'r') as mrcFile:
             im1 = MRCImage(mrcFile)	
    with open(diffmap1_filepath,'r') as mrcFile:
             im1sig = MRCImage(mrcFile)	
    with open(diffmap2_filepath,'r') as mrcFile:
             im2sig = MRCImage(mrcFile)
    [width, height] = cropImages(im1sig,im2sig)
    cropImage(im1, width, height)
    images = [im1sig, im2sig]
    max_val = scaleImages(images)
    cutImages(images)
    images.append(im1)
    if options.shift180:
        images = shiftImagesHalfX(images)
    plotImage(images[0].image, 1.0, options.map1_name)
    saveImage(images[0])
    plotImage(images[1].image, 1.0, options.map2_name)
    saveImage(images[1])
    contour = images[2].image
    if options.varmap:
        #TODO: check if varmap is scaled correctly
        varmap = getImage(options.varmap)
        raw_diffmap = getDiffmap(images[0],images[1])
        diffmap = significantDifferences(raw_diffmap, varmap, options.variation_factor)
        plotImage(varmap, 0.0, "variation")
        plotImage(raw_diffmap, 0.0, "raw difference map")
    else:
        diffmap = getDiffmap(images[0],images[1])
    plotDiffmap(contour, diffmap, options.map1_name, options.map2_name, options.colormap)
    plt.show()

	

	

	
