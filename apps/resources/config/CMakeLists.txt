#------------------------------------------------------------------------------
# @file CMakeLists.txt
# @author Nikhil Biyani
# @author Marcel Arheit
# @location 2dx/apps/resources/config
#------------------------------------------------------------------------------

#-- CMAKE Configurations ------------------------------------------------------
cmake_minimum_required(VERSION 2.8.11)
#------------------------------------------------------------------------------

get_filename_component(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} NAME)
set(INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/resources/${DIRECTORY})

# configure 2dx.cfg according to the os it is built on
if(APPLE)
	configure_file(2dx-mac.cfg ${INSTALL_DIR}/2dx.cfg COPYONLY)	
else(APPLE)
	configure_file(2dx-linux.cfg ${INSTALL_DIR}/2dx.cfg COPYONLY)	
endif(APPLE)

set(CONF 
        VARIABLE.txt 
        status-window
        2dx.cshrc 
        2dx_image-algo-1.jpg 
        2dx_image-algo-2.jpg 
        2dx_master.cfg
        navigator_help.htm
        2dx_status.html
        projectMenu.inf
        publications.list
        viewer.params.list
        lib.params.list
        import.params.list
        unique.params.list
        overviews.ini)

install(FILES ${CONF} DESTINATION ${INSTALL_DIR})
