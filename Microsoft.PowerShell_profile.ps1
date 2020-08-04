Set-Alias -name k -value kubectl
Set-Alias -name tf -value terraform

# Import-Module posh-git
# Import-Module oh-my-posh
Set-Theme Paradox-Michelotti

$DefaultUser = 'stemi'

function gac() {
  git add .
  git commit -m $args[0]
}
