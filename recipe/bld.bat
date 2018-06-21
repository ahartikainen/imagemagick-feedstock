REM set TMP="%LOCALAPPDATA%\Temp"
REM set TEMP="%LOCALAPPDATA%\T:emp"
REM set TMPDIR="%LOCALAPPDATA%\Temp"
IF "%ARCH%" == "64" (
set GCC_ARCH=x86_64-w64-mingw32
set EXTRA_FLAGS=-DMS_WIN64
) else (
set GCC_ARCH=i686-w64-mingw32
)

set CFLAGS="-I$PREFIX/include $CFLAGS"
set CPPFLAGS="-I$PREFIX/include $CPPFLAGS"
set LDFLAGS="-L$PREFIX/lib $LDFLAGS"

set configure ="./configure --prefix=$PREFIX --build=$GCC_ARCH --host=$GCC_ARCH --target=$GCC_ARCH --enable-hdri=yes --with-quantum-depth=16 --disable-docs --disable-static --disable-openmp --with-bzlib=yes --with-autotrace=no --with-djvu=no --with-dps=no --with-fftw=yes --with-flif=no --with-fpx=no --with-fontconfig=yes --with-freetype=yes --with-gslib=yes --with-gvc=yes --with-jbig=yes --with-jpeg=yes --with-lcms=no --with-lqr=no --with-ltdl=no --with-lzma=yes --with-magick-plus-plus=yes --with-openexr=no --with-openjp2=yes --with-pango=yes --with-perl=yes --with-png=yes --with-raqm=no --with-raw=no --with-rsvg=no --with-tiff=yes --with-webp=yes --with-wmf=no --with-x=yes --with-xml=yes --with-zlib=yes"

bash -lc configure

bash -lc "make -j$CPU_COUNT"
# FIXME:
# The failure below seems to be associated with the option --with-gslib,
# but I could not get to turn "yes." See the logs for more info.
#
# tests/wandtest.c main 5321 non-conforming drawing primitive definition `text' @ error/draw.c/DrawImage/3269`
# make check
bash -lc "make install -j$CPU_COUNT"
