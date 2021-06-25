TERMUX_PKG_HOMEPAGE=https://www.tug.org/texlive/
TERMUX_PKG_DESCRIPTION="TeX Live is a distribution of the TeX typesetting system. This package contains architecture dependent binaries."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="MURAMATSU Atsushi @amuramatsu"
TERMUX_PKG_VERSION=20210325
_SVN_VERSION=58837
TERMUX_PKG_SRCURL=https://github.com/TeX-Live/texlive-source/archive/svn${_SVN_VERSION}.tar.gz
TERMUX_PKG_SHA256=0afa6919e44675b7afe0fa45344747afef07b6ee98eeb14ff6a2ef78f458fc12
TERMUX_PKG_DEPENDS="libc++, libiconv, freetype, libpng, libgd, libgmp, libmpfr, libicu, liblua52, libgraphite, harfbuzz, harfbuzz-icu, teckit, libpixman, libcairo, zlib, zziplib, texlive-bin"
# libpcre, glib, fonconfig are dependencies to libcairo. pkg-config gives an error if they are missing
# libuuid, libxml2 are needed by fontconfig
TERMUX_PKG_BUILD_DEPENDS="icu-devtools, pcre, glib, fontconfig, libuuid, libxml2"
TERMUX_PKG_BREAKS="texlive (<< 20180414), texlive-bin-dev"
TERMUX_PKG_REPLACES="texlive (<< 20170524-3), texlive-bin-dev"
TERMUX_PKG_RECOMMENDS="texlive"
TERMUX_PKG_HOSTBUILD=true

TL_ROOT=$TERMUX_PREFIX/share/texlive
TL_BINDIR=$TERMUX_PREFIX/bin/texlive

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
RANLIB=ranlib
--mandir=$TERMUX_PREFIX/share/man
--infodir=$TERMUX_PREFIX/share/info
--bindir=$TL_BINDIR
--datarootdir=$TL_ROOT
--build=$TERMUX_BUILD_TUPLE
--disable-ttfdump
--disable-makeindexk
--enable-makejvf
--enable-mendexk
--enable-musixtnt
--disable-ps2pk
--disable-seetexk
--disable-gregorio
--disable-native-texlive-build
--enable-bibtexu
--disable-dvisvgm
--disable-dialog
--disable-psutils
--disable-multiplatform
--disable-t1utils
--disable-luatex
--disable-luajittex
--disable-luahbtex
--disable-luajithbtex
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
--with-system-zlib
--with-system-lua
--with-system-teckit
--with-system-zziplib
--without-x
--with-banner-add=/Termux"

# These files are provided by texlive:
TERMUX_PKG_RM_AFTER_INSTALL="
bin/a2ping
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
bin/texlive/a2ping
bin/texlive/a5toa4
bin/texlive/adhocfilelist
bin/texlive/afm2afm
bin/texlive/afm2pl
bin/texlive/afm2tfm
bin/texlive/albatross
bin/texlive/aleph
bin/texlive/allcm
bin/texlive/allec
bin/texlive/allneeded
bin/texlive/arara
bin/texlive/arlatex
bin/texlive/authorindex
bin/texlive/autoinst
bin/texlive/autosp
bin/texlive/axohelp
bin/texlive/bbl2bib
bin/texlive/bbox
bin/texlive/bg5+latex
bin/texlive/bg5+pdflatex
bin/texlive/bg5conv
bin/texlive/bg5latex
bin/texlive/bg5pdflatex
bin/texlive/bib2gls
bin/texlive/bibdoiadd
bin/texlive/bibexport
bin/texlive/bibmradd
bin/texlive/bibtex
bin/texlive/bibtex8
bin/texlive/biburl2doi
bin/texlive/bibzbladd
bin/texlive/bundledoc
bin/texlive/cachepic
bin/texlive/cef5conv
bin/texlive/cef5latex
bin/texlive/cef5pdflatex
bin/texlive/cefconv
bin/texlive/ceflatex
bin/texlive/cefpdflatex
bin/texlive/cefsconv
bin/texlive/cefslatex
bin/texlive/cefspdflatex
bin/texlive/cfftot1
bin/texlive/checkcites
bin/texlive/checklistings
bin/texlive/chkdvifont
bin/texlive/chklref
bin/texlive/chktex
bin/texlive/chkweb
bin/texlive/cjk-gs-integrate
bin/texlive/cllualatex
bin/texlive/cluttex
bin/texlive/clxelatex
bin/texlive/context
bin/texlive/contextjit
bin/texlive/convbkmk
bin/texlive/convertgls2bib
bin/texlive/ctan-o-mat
bin/texlive/ctanbib
bin/texlive/ctangle
bin/texlive/ctanify
bin/texlive/ctanupload
bin/texlive/ctie
bin/texlive/ctwill
bin/texlive/ctwill-refsort
bin/texlive/ctwill-twinx
bin/texlive/cweave
bin/texlive/de-macro
bin/texlive/depythontex
bin/texlive/detex
bin/texlive/devnag
bin/texlive/deweb
bin/texlive/diadia
bin/texlive/disdvi
bin/texlive/dosepsbin
bin/texlive/dt2dv
bin/texlive/dtxgen
bin/texlive/dv2dt
bin/texlive/dvi2fax
bin/texlive/dvi2tty
bin/texlive/dviasm
bin/texlive/dvicopy
bin/texlive/dvidvi
bin/texlive/dvigif
bin/texlive/dvihp
bin/texlive/dviinfox
bin/texlive/dvilj
bin/texlive/dvilj2p
bin/texlive/dvilj4
bin/texlive/dvilj4l
bin/texlive/dvilj6
bin/texlive/dvipdfm
bin/texlive/dvipdfmx
bin/texlive/dvipdft
bin/texlive/dvipng
bin/texlive/dvipos
bin/texlive/dvips
bin/texlive/dvired
bin/texlive/dvispc
bin/texlive/dvitomp
bin/texlive/dvitype
bin/texlive/e2pall
bin/texlive/ebb
bin/texlive/ebong
bin/texlive/epspdf
bin/texlive/epspdftk
bin/texlive/epstopdf
bin/texlive/eptex
bin/texlive/euptex
bin/texlive/exceltex
bin/texlive/extconv
bin/texlive/extractbb
bin/texlive/fig4latex
bin/texlive/findhyph
bin/texlive/fmtutil
bin/texlive/fmtutil-sys
bin/texlive/fmtutil-user
bin/texlive/fontinst
bin/texlive/fragmaster
bin/texlive/gbklatex
bin/texlive/gbkpdflatex
bin/texlive/getmapdl
bin/texlive/gftodvi
bin/texlive/gftopk
bin/texlive/gftype
bin/texlive/git-latexdiff
bin/texlive/gsftopk
bin/texlive/hbf2gf
bin/texlive/ht
bin/texlive/htcontext
bin/texlive/htlatex
bin/texlive/htmex
bin/texlive/httex
bin/texlive/httexi
bin/texlive/htxelatex
bin/texlive/htxetex
bin/texlive/hyperxmp-add-bytecount
bin/texlive/inimf
bin/texlive/initex
bin/texlive/installfont-tl
bin/texlive/jamo-normalize
bin/texlive/jfmutil
bin/texlive/kanji-config-updmap
bin/texlive/kanji-config-updmap-sys
bin/texlive/kanji-config-updmap-user
bin/texlive/kanji-fontmap-creator
bin/texlive/ketcindy
bin/texlive/komkindex
bin/texlive/kpseaccess
bin/texlive/kpsepath
bin/texlive/kpsereadlink
bin/texlive/kpsestat
bin/texlive/kpsetool
bin/texlive/kpsewhere
bin/texlive/kpsewhich
bin/texlive/kpsexpand
bin/texlive/l3build
bin/texlive/lacheck
bin/texlive/latex-git-log
bin/texlive/latex-papersize
bin/texlive/latex2man
bin/texlive/latex2nemeth
bin/texlive/latexdef
bin/texlive/latexdiff
bin/texlive/latexdiff-vc
bin/texlive/latexfileversion
bin/texlive/latexindent
bin/texlive/latexmk
bin/texlive/latexpand
bin/texlive/latexrevise
bin/texlive/lily-glyph-commands
bin/texlive/lily-image-commands
bin/texlive/lily-rebuild-pdfs
bin/texlive/listbib
bin/texlive/listings-ext.sh
bin/texlive/llmk
bin/texlive/ltx2crossrefxml
bin/texlive/ltxfileinfo
bin/texlive/ltximg
bin/texlive/lua2dox_filter
bin/texlive/luaotfload-tool
bin/texlive/luatools
bin/texlive/lwarpmk
bin/texlive/m-tx
bin/texlive/make4ht
bin/texlive/makedtx
bin/texlive/makeglossaries
bin/texlive/makeglossaries-lite
bin/texlive/match_parens
bin/texlive/mathspic
bin/texlive/mf
bin/texlive/mf-nowin
bin/texlive/mf2pt1
bin/texlive/mfplain
bin/texlive/mft
bin/texlive/mk4ht
bin/texlive/mkgrkindex
bin/texlive/mkjobtexmf
bin/texlive/mkocp
bin/texlive/mkofm
bin/texlive/mkpic
bin/texlive/mkt1font
bin/texlive/mktexfmt
bin/texlive/mktexlsr
bin/texlive/mktexmf
bin/texlive/mktexpk
bin/texlive/mktextfm
bin/texlive/mmafm
bin/texlive/mmpfb
bin/texlive/mpost
bin/texlive/mptopdf
bin/texlive/mtxrun
bin/texlive/mtxrunjit
bin/texlive/multibibliography
bin/texlive/musixflx
bin/texlive/musixtex
bin/texlive/odvicopy
bin/texlive/odvitype
bin/texlive/ofm2opl
bin/texlive/omfonts
bin/texlive/opl2ofm
bin/texlive/ot2kpx
bin/texlive/otangle
bin/texlive/otfinfo
bin/texlive/otftotfm
bin/texlive/otp2ocp
bin/texlive/outocp
bin/texlive/ovf2ovp
bin/texlive/ovp2ovf
bin/texlive/pamphletangler
bin/texlive/patgen
bin/texlive/pbibtex
bin/texlive/pdf180
bin/texlive/pdf270
bin/texlive/pdf90
bin/texlive/pdfannotextractor
bin/texlive/pdfatfi
bin/texlive/pdfbook
bin/texlive/pdfbook2
bin/texlive/pdfcrop
bin/texlive/pdfflip
bin/texlive/pdfjam
bin/texlive/pdfjam-pocketmod
bin/texlive/pdfjam-slides3up
bin/texlive/pdfjam-slides6up
bin/texlive/pdfjoin
bin/texlive/pdflatexpicscale
bin/texlive/pdfnup
bin/texlive/pdfpun
bin/texlive/pdftex
bin/texlive/pdftex-quiet
bin/texlive/pdftosrc
bin/texlive/pdfxup
bin/texlive/pdvitomp
bin/texlive/pdvitype
bin/texlive/pedigree
bin/texlive/perltex
bin/texlive/pfarrei
bin/texlive/pkfix
bin/texlive/pkfix-helper
bin/texlive/pktogf
bin/texlive/pktype
bin/texlive/pltotf
bin/texlive/pmpost
bin/texlive/pmxchords
bin/texlive/pn2pdf
bin/texlive/pooltype
bin/texlive/ppltotf
bin/texlive/prepmx
bin/texlive/ps2eps
bin/texlive/ps2frag
bin/texlive/ps4pdf
bin/texlive/pslatex
bin/texlive/pst2pdf
bin/texlive/ptex
bin/texlive/ptex2pdf
bin/texlive/ptftopl
bin/texlive/purifyeps
bin/texlive/pygmentex
bin/texlive/pythontex
bin/texlive/r-mpost
bin/texlive/r-pmpost
bin/texlive/r-upmpost
bin/texlive/repstopdf
bin/texlive/rpdfcrop
bin/texlive/rubibtex
bin/texlive/rubikrotation
bin/texlive/rumakeindex
bin/texlive/rungs
bin/texlive/simpdftex
bin/texlive/sjisconv
bin/texlive/sjislatex
bin/texlive/sjispdflatex
bin/texlive/spix
bin/texlive/splitindex
bin/texlive/srcredact
bin/texlive/sty2dtx
bin/texlive/svn-multi
bin/texlive/synctex
bin/texlive/texplate
bin/texlive/t1dotlessj
bin/texlive/t1lint
bin/texlive/t1rawafm
bin/texlive/t1reencode
bin/texlive/t1testpage
bin/texlive/t4ht
bin/texlive/tangle
bin/texlive/tex
bin/texlive/tex2aspc
bin/texlive/tex4ebook
bin/texlive/tex4ht
bin/texlive/texconfig
bin/texlive/texconfig-dialog
bin/texlive/texconfig-sys
bin/texlive/texcount
bin/texlive/texdef
bin/texlive/texdiff
bin/texlive/texdirflatten
bin/texlive/texdoc
bin/texlive/texdoctk
bin/texlive/texexec
bin/texlive/texfot
bin/texlive/texhash
bin/texlive/texlinks
bin/texlive/texliveonfly
bin/texlive/texloganalyser
bin/texlive/texmfstart
bin/texlive/texosquery
bin/texlive/texosquery-jre5
bin/texlive/texosquery-jre8
bin/texlive/tftopl
bin/texlive/thumbpdf
bin/texlive/tie
bin/texlive/tikztosvg
bin/texlive/tlcockpit
bin/texlive/tlmgr
bin/texlive/tlshell
bin/texlive/tpic2pdftex
bin/texlive/ttf2afm
bin/texlive/ttf2kotexfont
bin/texlive/ttf2pk
bin/texlive/ttf2tfm
bin/texlive/ttftotype42
bin/texlive/typeoutfileinfo
bin/texlive/ulqda
bin/texlive/upbibtex
bin/texlive/updmap
bin/texlive/updmap-sys
bin/texlive/updmap-user
bin/texlive/updvitomp
bin/texlive/updvitype
bin/texlive/upmendex
bin/texlive/upmpost
bin/texlive/uppltotf
bin/texlive/uptex
bin/texlive/uptftopl
bin/texlive/urlbst
bin/texlive/vftovp
bin/texlive/vlna
bin/texlive/vpe
bin/texlive/vpl2ovp
bin/texlive/vpl2vpl
bin/texlive/vptovf
bin/texlive/weave
bin/texlive/webquiz
bin/texlive/wofm2opl
bin/texlive/wopl2ofm
bin/texlive/wordcount
bin/texlive/wovf2ovp
bin/texlive/wovp2ovf
bin/texlive/xdvipdfmx
bin/texlive/xetex
bin/texlive/xhlatex
bin/texlive/xindex
bin/texlive/xml2pmx
bin/texlive/yplan
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
share/man/man1/dvilualatex-dev.1
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
share/man/man1/latex-dev.1
share/man/man1/luatex.1
share/man/man1/lualatex-dev.1
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
share/man/man1/pdflatex-dev.1
share/man/man1/pdftex.1
share/man/man1/pdftosrc.1
share/man/man1/pktogf.1
share/man/man1/pktype.1
share/man/man1/pltotf.1
share/man/man1/platex-dev.1
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
share/man/man1/uplatex-dev.1
share/man/man1/uptftopl.1
share/man/man1/vftovp.1
share/man/man1/vlna.1
share/man/man1/vptovf.1
share/man/man1/weave.1
share/man/man1/xdvipdfmx.1
share/man/man1/xetex.1
share/man/man1/xelatex-dev.1
share/man/man1/xml2pmx.1
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
	export OTANGLE=$TERMUX_PKG_HOSTBUILD_DIR/texk/web2c/otangle
}
