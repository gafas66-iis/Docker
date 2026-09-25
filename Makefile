################################################################################
# Created: Monday, September 21 2026
# Author: , ESK
.ONESHELL:

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

player:
	git clone https://github.com/RobolabUACJ/katana.git
	cd katana

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
run:
	-sudo docker rm -f playerstage
	sudo docker run -td -p 2225:22 \
	--name playerstage \
	-v home:/home/erik \
	playerstage

# End of file
################################################################################
# Local Variables:
# comment-column: 60
# End:
################################################################################
