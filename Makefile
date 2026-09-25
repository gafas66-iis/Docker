################################################################################
# Created: Monday, September 21 2026
# Author: , ESK
.ONESHELL:

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

clean:; rm -fr player/build Stage/build
player:
	git clone https://github.com/playerproject/player.git
	cd player

	CM=$$(find . -type f -name CMakeLists.txt)
	# C Language standard must be C11 (not C17 or other)
	sed -i '1s/^/set (CMAKE_CXX_STANDARD_REQUIRED ON)\n/' $${CM}
	sed -i '1s/^/set (CMAKE_CXX_STANDARD 11)\n/'          $${CM}
	# Policies are deprecated - use OLD
	sed -i '1s/^/cmake_policy(SET CMP0148 OLD)\n/'        $${CM}
	sed -i '1s/^/cmake_policy(SET CMP0167 OLD)\n/'        $${CM}

player/build: player
	cd player
	mkdir build
	cd build
	cmake ../
	make
	make install

	echo 'export PATH=${PATH}:/usr/local/bin'                       >> /etc/profile
	echo 'export PLAYERPATH="/usr/local/lib"'                       >> /etc/profile
	echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib' >> /etc/profile

stage:
	git clone https://github.com/rtv/Stage.git
	export STG=$HOME/stg
	cd Stage
	sed -i '1s/^/target_include_directories (/usr/local/ntirpc)\n/' ${CM}	
	mkdir build;cd build
	cmake -DCMAKE_INSTALL_PREFIX=${STG} ../
	make
	sudo make install

build:; sudo docker build -t playerstage -f PlayerStage .
#build:; sudo docker build -t playerstage -f AIPlayerStage .
start:
	-sudo docker rm -f test1
	sudo docker run -td -p 2225:22 \
	--name test1 \
	-v /home/demo_10g:/home/demo_10g \
	playerstage

# End of file
################################################################################
# Local Variables:
# comment-column: 60
# End:
################################################################################
