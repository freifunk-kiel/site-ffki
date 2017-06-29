function ramips-rt305x_BUILD_PRE
{
	echo Applying rt3052 patches
	git am site/patches/ramips-rt305x/gluon/*.patch
	(cd lede; git am ../site/patches/ramips-rt305x/lede/*.patch)
}
