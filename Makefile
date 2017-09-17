prefix  ?= ${CURDIR}/docs
latexmk := latexmk -xelatex --output-directory=${prefix} -cd
stdlib  ?= $(shell nix-build '<nixpkgs>' -A AgdaStdlib --no-out-link)
agda    := agda -i ${stdlib}/share/agda
srcs    := $(wildcard WPiG/**/*.lagda.tex)
htmls   := $(addprefix ${prefix}/,$(subst /,.,${srcs:%.lagda.tex=%.html}))
texs    := ${srcs:%.lagda.tex=latex/%.tex}


.PHONY: all html pdf


all: pdf html


pdf: docs/WPiG.pdf


html: ${htmls}


${htmls}: ${srcs}
	$(foreach src,$^, ${agda} --html --html-dir=${prefix} ${src};)


latex/%.tex: %.lagda.tex
	${agda} --latex $<


docs/WPiG.pdf: latex/WPiG.tex ${texs}
	@ mkdir -p $(@D)
	${latexmk} -gg $<
	${latexmk} -c $<
	@ rm -f $(@D)/*.{ptb,xdv}
