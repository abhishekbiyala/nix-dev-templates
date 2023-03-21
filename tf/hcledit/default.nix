{ lib, buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "hcledit";
  version = "0.2.6";

  src = fetchFromGitHub {
    owner = "minamijoyo";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-UmgXsAqJ/pgeJgsRT5KKVLuD4kocHz8OnUt3tqtR7to=";
  };

  vendorSha256 = "sha256-K/B0WuNbw5vk4Ma2U5rtYZxhtjXhUPybtxbkFUnwYoM=";

  subPackages = [ "." ];

  meta = with lib; {
    description = "A command line editor for HCL";
    homepage = "https://github.com/minamijoyo/hcledit/";
    license = licenses.mit;
    maintainers = with maintainers; [ abhishekbiyala ];
  };
}
