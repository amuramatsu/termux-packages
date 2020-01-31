TERMUX_PKG_HOMEPAGE=https://www.tug.org/texlive/
TERMUX_PKG_DESCRIPTION="TeX Live is a distribution of the TeX typesetting system. This package contains architecture dependent binaries."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="MURAMATSU Atsushi @amuramatsu"
TERMUX_PKG_VERSION=20190410
TERMUX_PKG_REVISION=8
TERMUX_PKG_SRCURL=https://github.com/TeX-Live/texlive-source/archive/build-svn51263.tar.gz
TERMUX_PKG_SHA256=fb117eca01d1561a8e86adf74081a554d59799c7b3b15a1944418f8f30af621d
TERMUX_PKG_DEPENDS="libc++, libiconv, freetype, libpng, libgd, libgmp, libmpfr, libicu, liblua, poppler, libgraphite, harfbuzz, harfbuzz-icu, teckit, libpixman, libcairo, zlib, texlive-bin"
# libpcre, glib, fonconfig are dependencies to libcairo. pkg-config gives an error if they are missing
# libuuid, libxml2 are needed by fontconfig
TERMUX_PKG_BUILD_DEPENDS="icu-devtools, pcre, glib, fontconfig, libuuid, libxml2"
TERMUX_PKG_BREAKS="texlive (<< 20180414)"
TERMUX_PKG_REPLACES="texlive (<< 20170524-3)"
TERMUX_PKG_RECOMMENDS="texlive"
TERMUX_PKG_HOSTBUILD=true

TL_ROOT=$TERMUX_PREFIX/share/texlive
TL_BINDIR=$TERMUX_PREFIX/bin

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
RANLIB=ranlib
--mandir=$TERMUX_PREFIX/share/man
--infodir=$TERMUX_PREFIX/share/info
--datarootdir=$TL_ROOT
--build=$TERMUX_BUILD_TUPLE
--enable-ttfdump=no
--enable-makeindexk=no
--enable-makejvf=yes
--enable-mendexk=yes
--enable-musixtnt=yes
--enable-ps2pk=no
--enable-seetexk=no
--enable-gregorio=no
--disable-native-texlive-build
--enable-bibtexu
--enable-dvisvgm
--disable-dialog
--disable-psutils
--disable-multiplatform
--disable-t1utils
--disable-luatex
--disable-luajittex
--enable-mflua
--disable-mfluajit
--disable-xz
--disable-pmx
--without-texinfo
--without-xdvipdfmx
--without-texi2html
--with-system-cairo
--with-system-graphite2
--with-system-harfbuzz
--with-system-gd
--with-system-gmp
--with-system-icu
--with-system-mpfr
--with-system-poppler
--with-system-zlib
--with-system-xpdf
--with-system-lua
--with-system-teckit
--without-x
--with-banner-add=/Termux"

# These files are provided by texlive:
TERMUX_PKG_RM_AFTER_INSTALL="
bin/tlmgr
bin/man
share/texlive/texmf-dist/web2c/mktex.opt
share/texlive/texmf-dist/web2c/mktexdir.opt
share/texlive/texmf-dist/web2c/mktexnam.opt
share/texlive/texmf-dist/web2c/fmtutil.cnf
share/texlive/texmf-dist/web2c/mktexdir
share/texlive/texmf-dist/web2c/mktexnam
share/texlive/texmf-dist/web2c/mktexupd
share/texlive/texmf-dist/web2c/texmf.cnf
share/texlive/texmf-dist/fonts
share/texlive/texmf-dist/doc
share/texlive/texmf-dist/dvips
share/texlive/texmf-dist/dvipdfmx
share/texlive/texmf-dist/texconfig
share/texlive/texmf-dist/bibtex
share/texlive/texmf-dist/scripts
share/texlive/texmf-dist/ttf2pk
share/texlive/texmf-dist/source
share/texlive/texmf-dist/chktex
share/texlive/texmf-dist/hbf2gf
include
lib/pkgconfig
bin/a2ping
bin/a5toa4
bin/adhocfilelist
bin/afm2afm
bin/afm2pl
bin/afm2tfm
bin/aleph
bin/allcm
bin/allec
bin/allneeded
bin/arara
bin/arlatex
bin/authorindex
bin/autoinst
bin/autosp
bin/axohelp
bin/bbl2bib
bin/bbox
bin/bg5+latex
bin/bg5+pdflatex
bin/bg5conv
bin/bg5latex
bin/bg5pdflatex
bin/bib2gls
bin/bibdoiadd
bin/bibexport
bin/bibmradd
bin/bibtex
bin/bibtex8
bin/biburl2doi
bin/bibzbladd
bin/bundledoc
bin/cachepic
bin/cef5conv
bin/cef5latex
bin/cef5pdflatex
bin/cefconv
bin/ceflatex
bin/cefpdflatex
bin/cefsconv
bin/cefslatex
bin/cefspdflatex
bin/cfftot1
bin/checkcites
bin/checklistings
bin/chkdvifont
bin/chktex
bin/chkweb
bin/cjk-gs-integrate
bin/cllualatex
bin/cluttex
bin/clxelatex
bin/context
bin/contextjit
bin/convbkmk
bin/convertgls2bib
bin/ctan-o-mat
bin/ctanbib
bin/ctangle
bin/ctanify
bin/ctanupload
bin/ctie
bin/ctwill
bin/ctwill-refsort
bin/ctwill-twinx
bin/cweave
bin/de-macro
bin/depythontex
bin/detex
bin/devnag
bin/deweb
bin/diadia
bin/disdvi
bin/dosepsbin
bin/dt2dv
bin/dtxgen
bin/dv2dt
bin/dvi2fax
bin/dvi2tty
bin/dviasm
bin/dvicopy
bin/dvidvi
bin/dvigif
bin/dvihp
bin/dviinfox
bin/dvilj
bin/dvilj2p
bin/dvilj4
bin/dvilj4l
bin/dvilj6
bin/dvipdfm
bin/dvipdfmx
bin/dvipdft
bin/dvipng
bin/dvipos
bin/dvips
bin/dvired
bin/dvispc
bin/dvitomp
bin/dvitype
bin/e2pall
bin/ebb
bin/ebong
bin/epspdf
bin/epspdftk
bin/epstopdf
bin/eptex
bin/euptex
bin/exceltex
bin/extconv
bin/extractbb
bin/fig4latex
bin/findhyph
bin/fmtutil
bin/fmtutil-sys
bin/fmtutil-user
bin/fontinst
bin/fragmaster
bin/gbklatex
bin/gbkpdflatex
bin/getmapdl
bin/gftodvi
bin/gftopk
bin/gftype
bin/gsftopk
bin/hbf2gf
bin/ht
bin/htcontext
bin/htlatex
bin/htmex
bin/httex
bin/httexi
bin/htxelatex
bin/htxetex
bin/inimf
bin/initex
bin/installfont-tl
bin/jamo-normalize
bin/jfmutil
bin/kanji-config-updmap
bin/kanji-config-updmap-sys
bin/kanji-config-updmap-user
bin/kanji-fontmap-creator
bin/komkindex
bin/kpseaccess
bin/kpsepath
bin/kpsereadlink
bin/kpsestat
bin/kpsetool
bin/kpsewhere
bin/kpsewhich
bin/kpsexpand
bin/l3build
bin/lacheck
bin/latex-git-log
bin/latex-papersize
bin/latex2man
bin/latex2nemeth
bin/latexdef
bin/latexdiff
bin/latexdiff-vc
bin/latexfileversion
bin/latexindent
bin/latexmk
bin/latexpand
bin/latexrevise
bin/lily-glyph-commands
bin/lily-image-commands
bin/lily-rebuild-pdfs
bin/listbib
bin/listings-ext.sh
bin/ltx2crossrefxml
bin/ltxfileinfo
bin/ltximg
bin/lua2dox_filter
bin/luaotfload-tool
bin/luatools
bin/lwarpmk
bin/m-tx
bin/make4ht
bin/makedtx
bin/makeglossaries
bin/makeglossaries-lite
bin/match_parens
bin/mathspic
bin/mf
bin/mf-nowin
bin/mf2pt1
bin/mfplain
bin/mft
bin/mk4ht
bin/mkgrkindex
bin/mkjobtexmf
bin/mkocp
bin/mkofm
bin/mkpic
bin/mkt1font
bin/mktexfmt
bin/mktexlsr
bin/mktexmf
bin/mktexpk
bin/mktextfm
bin/mmafm
bin/mmpfb
bin/mpost
bin/mptopdf
bin/mtxrun
bin/mtxrunjit
bin/multibibliography
bin/musixflx
bin/musixtex
bin/odvicopy
bin/odvitype
bin/ofm2opl
bin/omfonts
bin/opl2ofm
bin/ot2kpx
bin/otangle
bin/otfinfo
bin/otftotfm
bin/otp2ocp
bin/outocp
bin/ovf2ovp
bin/ovp2ovf
bin/patgen
bin/pbibtex
bin/pdf180
bin/pdf270
bin/pdf90
bin/pdfannotextractor
bin/pdfatfi
bin/pdfbook
bin/pdfbook2
bin/pdfcrop
bin/pdfflip
bin/pdfjam
bin/pdfjam-pocketmod
bin/pdfjam-slides3up
bin/pdfjam-slides6up
bin/pdfjoin
bin/pdflatexpicscale
bin/pdfnup
bin/pdfpun
bin/pdftex
bin/pdftex-quiet
bin/pdftosrc
bin/pdfxup
bin/pdvitomp
bin/pdvitype
bin/pedigree
bin/perltex
bin/pfarrei
bin/pkfix
bin/pkfix-helper
bin/pktogf
bin/pktype
bin/pltotf
bin/pmpost
bin/pmxchords
bin/pn2pdf
bin/pooltype
bin/ppltotf
bin/prepmx
bin/ps2eps
bin/ps2frag
bin/ps4pdf
bin/pslatex
bin/pst2pdf
bin/ptex
bin/ptex2pdf
bin/ptftopl
bin/purifyeps
bin/pygmentex
bin/pythontex
bin/r-mpost
bin/r-pmpost
bin/r-upmpost
bin/repstopdf
bin/rpdfcrop
bin/rubibtex
bin/rubikrotation
bin/rumakeindex
bin/rungs
bin/simpdftex
bin/sjisconv
bin/sjislatex
bin/sjispdflatex
bin/splitindex
bin/srcredact
bin/sty2dtx
bin/svn-multi
bin/synctex
bin/t1dotlessj
bin/t1lint
bin/t1rawafm
bin/t1reencode
bin/t1testpage
bin/t4ht
bin/tangle
bin/tex
bin/tex2aspc
bin/tex4ebook
bin/tex4ht
bin/texconfig
bin/texconfig-dialog
bin/texconfig-sys
bin/texcount
bin/texdef
bin/texdiff
bin/texdirflatten
bin/texdoc
bin/texdoctk
bin/texexec
bin/texfot
bin/texhash
bin/texlinks
bin/texliveonfly
bin/texloganalyser
bin/texmfstart
bin/texosquery
bin/texosquery-jre5
bin/texosquery-jre8
bin/tftopl
bin/thumbpdf
bin/tie
bin/tlcockpit
bin/tlshell
bin/tpic2pdftex
bin/ttf2afm
bin/ttf2kotexfont
bin/ttf2pk
bin/ttf2tfm
bin/ttftotype42
bin/typeoutfileinfo
bin/ulqda
bin/upbibtex
bin/updmap
bin/updmap-sys
bin/updmap-user
bin/updvitomp
bin/updvitype
bin/upmendex
bin/upmpost
bin/uppltotf
bin/uptex
bin/uptftopl
bin/urlbst
bin/vftovp
bin/vlna
bin/vpe
bin/vpl2ovp
bin/vpl2vpl
bin/vptovf
bin/weave
bin/webquiz
bin/wofm2opl
bin/wopl2ofm
bin/wordcount
bin/wovf2ovp
bin/wovp2ovf
bin/xdvipdfmx
bin/xetex
bin/xhlatex
bin/xindex
bin/yplan
lib/libkpathsea.so
lib/libptexenc.so
lib/libsynctex.so
lib/libtexlua53.so
share/man/man1/afm2pl.1
share/man/man1/afm2tfm.1
share/man/man1/aleph.1
share/man/man1/allcm.1
share/man/man1/allec.1
share/man/man1/allneeded.1
share/man/man1/amstex.1
share/man/man1/autosp.1
share/man/man1/axohelp.1
share/man/man1/bbox.1
share/man/man1/bg5conv.1
share/man/man1/bibtex.1
share/man/man1/bibtex8.1
share/man/man1/bibtexu.1
share/man/man1/cef5conv.1
share/man/man1/cefconv.1
share/man/man1/cefsconv.1
share/man/man1/cfftot1.1
share/man/man1/chkdvifont.1
share/man/man1/chktex.1
share/man/man1/chkweb.1
share/man/man1/ctangle.1
share/man/man1/ctie.1
share/man/man1/ctwill-refsort.1
share/man/man1/ctwill-twinx.1
share/man/man1/ctwill.1
share/man/man1/cweave.1
share/man/man1/cweb.1
share/man/man1/detex.1
share/man/man1/devnag.1
share/man/man1/deweb.1
share/man/man1/disdvi.1
share/man/man1/dt2dv.1
share/man/man1/dv2dt.1
share/man/man1/dvi2fax.1
share/man/man1/dvi2tty.1
share/man/man1/dvicopy.1
share/man/man1/dvidvi.1
share/man/man1/dvigif.1
share/man/man1/dvihp.1
share/man/man1/dvilj.1
share/man/man1/dvilj2p.1
share/man/man1/dvilj4.1
share/man/man1/dvilj4l.1
share/man/man1/dvilj6.1
share/man/man1/dvipdfm.1
share/man/man1/dvipdfmx.1
share/man/man1/dvipdft.1
share/man/man1/dvipng.1
share/man/man1/dvipos.1
share/man/man1/dvips.1
share/man/man1/dvired.1
share/man/man1/dvispc.1
share/man/man1/dvitomp.1
share/man/man1/dvitype.1
share/man/man1/e2pall.1
share/man/man1/ebb.1
share/man/man1/eptex.1
share/man/man1/euptex.1
share/man/man1/extconv.1
share/man/man1/extractbb.1
share/man/man1/fmtutil-sys.1
share/man/man1/fmtutil.1
share/man/man1/fontinst.1
share/man/man1/gftodvi.1
share/man/man1/gftopk.1
share/man/man1/gftype.1
share/man/man1/gsftopk.1
share/man/man1/hbf2gf.1
share/man/man1/inimf.1
share/man/man1/initex.1
share/man/man1/kpseaccess.1
share/man/man1/kpsepath.1
share/man/man1/kpsereadlink.1
share/man/man1/kpsestat.1
share/man/man1/kpsetool.1
share/man/man1/kpsewhere.1
share/man/man1/kpsewhich.1
share/man/man1/kpsexpand.1
share/man/man1/lacheck.1
share/man/man1/lamed.1
share/man/man1/latex.1
share/man/man1/luatex.1
share/man/man1/makeindex.1
share/man/man1/mf-nowin.1
share/man/man1/mf.1
share/man/man1/mft.1
share/man/man1/mkindex.1
share/man/man1/mkocp.1
share/man/man1/mkofm.1
share/man/man1/mktexfmt.1
share/man/man1/mktexlsr.1
share/man/man1/mktexmf.1
share/man/man1/mktexpk.1
share/man/man1/mktextfm.1
share/man/man1/mmafm.1
share/man/man1/mmpfb.1
share/man/man1/mpost.1
share/man/man1/odvicopy.1
share/man/man1/odvitype.1
share/man/man1/ofm2opl.1
share/man/man1/opl2ofm.1
share/man/man1/otangle.1
share/man/man1/otfinfo.1
share/man/man1/otftotfm.1
share/man/man1/otp2ocp.1
share/man/man1/outocp.1
share/man/man1/ovf2ovp.1
share/man/man1/ovp2ovf.1
share/man/man1/patgen.1
share/man/man1/pdfetex.1
share/man/man1/pdflatex.1
share/man/man1/pdftex.1
share/man/man1/pdftosrc.1
share/man/man1/pktogf.1
share/man/man1/pktype.1
share/man/man1/pltotf.1
share/man/man1/pooltype.1
share/man/man1/ppltotf.1
share/man/man1/prepmx.1
share/man/man1/ps2eps.1
share/man/man1/ps2frag.1
share/man/man1/pslatex.1
share/man/man1/ptex.1
share/man/man1/ptftopl.1
share/man/man1/rubibtex.1
share/man/man1/rumakeindex.1
share/man/man1/sjisconv.1
share/man/man1/synctex.1
share/man/man1/t1dotlessj.1
share/man/man1/t1lint.1
share/man/man1/t1rawafm.1
share/man/man1/t1reencode.1
share/man/man1/t1testpage.1
share/man/man1/tangle.1
share/man/man1/tex.1
share/man/man1/tex2aspc.1
share/man/man1/texconfig-sys.1
share/man/man1/texconfig.1
share/man/man1/texdoctk.1
share/man/man1/texhash.1
share/man/man1/texlinks.1
share/man/man1/tftopl.1
share/man/man1/tie.1
share/man/man1/tpic2pdftex.1
share/man/man1/ttf2afm.1
share/man/man1/ttf2pk.1
share/man/man1/ttf2tfm.1
share/man/man1/ttftotype42.1
share/man/man1/updmap-sys.1
share/man/man1/updmap.1
share/man/man1/uppltotf.1
share/man/man1/uptex.1
share/man/man1/uptftopl.1
share/man/man1/vftovp.1
share/man/man1/vlna.1
share/man/man1/vptovf.1
share/man/man1/weave.1
share/man/man1/xdvipdfmx.1
share/man/man1/xetex.1
share/man/man5/fmtutil.cnf.5
share/man/man5/synctex.5
share/man/man5/updmap.cfg.5
share/info/dvips.info
share/info/dvipng.info
share/info/tlbuild.info
share/info/kpathsea.info
share/info/web2c.info
"

termux_step_host_build() {
	mkdir -p auxdir/auxsub
	mkdir -p texk/kpathsea
	mkdir -p texk/web2c

	cd $TERMUX_PKG_HOSTBUILD_DIR/auxdir/auxsub
	$TERMUX_PKG_SRCDIR/auxdir/auxsub/configure
	make

	cd $TERMUX_PKG_HOSTBUILD_DIR/texk/kpathsea
	$TERMUX_PKG_SRCDIR/texk/kpathsea/configure

	cd $TERMUX_PKG_HOSTBUILD_DIR/texk/web2c
	$TERMUX_PKG_SRCDIR/texk/web2c/configure --without-x
	make tangle
	make ctangle
	make tie
	make otangle
}

termux_step_pre_configure() {
	# When building against libicu 59.1 or later we need c++11:
	CXXFLAGS+=" -std=c++11"
	export TANGLE=$TERMUX_PKG_HOSTBUILD_DIR/texk/web2c/tangle
	export TANGLEBOOT=$TERMUX_PKG_HOSTBUILD_DIR/texk/web2c/tangleboot
	export CTANGLE=$TERMUX_PKG_HOSTBUILD_DIR/texk/web2c/ctangle
	export CTANGLEBOOT=$TERMUX_PKG_HOSTBUILD_DIR/texk/web2c/ctangleboot
	export TIE=$TERMUX_PKG_HOSTBUILD_DIR/texk/web2c/tie
	export OTANGLE=$TERMUX_PKG_HOSTBUILD_DIR/texk/web2c/.libs/otangle
	# otangle is linked against libkpathsea but can't find it, so we use LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$TERMUX_PKG_HOSTBUILD_DIR/texk/kpathsea/.libs

	find "$TERMUX_PKG_SRCDIR"/texk/web2c/luatexdir -type f -exec sed -i \
	     -e 's|gTrue|true|g' \
	     -e 's|gFalse|false|g' \
	     -e 's|GBool|bool|g' \
	     -e 's|getCString|c_str|g' \
	     -e 's|Guint|unsigned int|g' \
	     -e 's|Guchar|unsigned char|g' \
	     {} +

	# These files are from upstream master:
	cp "$TERMUX_PKG_BUILDER_DIR"/pdftoepdf-poppler0.83.0.cc "$TERMUX_PKG_SRCDIR"/texk/web2c/pdftexdir/pdftoepdf.cc # commit f0d0598b
	cp "$TERMUX_PKG_BUILDER_DIR"/pdftosrc-poppler0.83.0.cc "$TERMUX_PKG_SRCDIR"/texk/web2c/pdftexdir/pdftosrc.cc # commit f0d0598b
}
