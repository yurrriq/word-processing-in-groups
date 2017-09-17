$clean_ext .= ' %R.ist %R.xdy';
$pdflatex   = q/xelatex %O --shell-escape %S/;


add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');


sub run_makeglossaries {
    if ( $silent ) {
        system "makeglossaries -d ../docs -q '$_[0]'";
    }
    else {
        system "makeglossaries -d ../docs '$_[0]'";
    };
}


push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';