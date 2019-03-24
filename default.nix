{ nixpkgs ? <nixpkgs>
# Run "nix-build --argstr date YYYY-MM-DD" to reproduce a build:
, date ? null
}:

with import nixpkgs {};

stdenv.mkDerivation rec {
  name = "satzung-${version}";
  version = if (date != null)
    then date
    else lib.fileContents
      (runCommand "satzung-date" {} "date --utc +'%F' > $out");

  src = lib.cleanSource ./.;

  nativeBuildInputs = [
    (texlive.combine {
      inherit (texlive) scheme-minimal latexmk latexconfig latex koma-script
        graphics babel babel-german hyphen-german collection-fontsrecommended
        microtype paralist hyperref oberdiek url todonotes xkeyval xcolor pgf
        tools titlesec chngcntr;
    })
  ];

  postPatch = ''
    # Set SOURCE_DATE_EPOCH to make the build reproducible:
    export SOURCE_DATE_EPOCH="$(date --date=$version +'%s')"
    # TODO: Override the LaTeX values for \today
  '';

  buildPhase = ''
    # Build the PDFs:
    make distclean
    make
  '';

  installPhase = ''
    mkdir $out
    cp satzung.pdf $out/satzung.pdf
  '';
}
