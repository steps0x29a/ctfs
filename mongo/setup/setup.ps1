Import-Module BitsTransfer

Function pause ($message)
{
    # Check if running Powershell ISE
    if ($psISE)
    {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("$message")
    }
    else
    {
        Write-Host "$message" -ForegroundColor Yellow
        $x = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}

$workingDir = "$env:LOCALAPPDATA\ctf\mongo"
$ticks = Get-Date | Select-Object Ticks -ExpandProperty Ticks
$iso = "$workingDir\nixos.iso"
$hdd = "$workingDir\victim_$ticks.vdi"

# Make sure directory LOCALAPPDATA\ctf\mongo exists
New-Item -ItemType Directory -Force -Path "$workingDir" | Out-Null

# If nixos.iso does not exist in %APPDATA%\ctf\mongo, download it
if (-not (Test-Path "$iso")) {
  Start-BitsTransfer "https://channels.nixos.org/nixos-23.05/latest-nixos-gnome-x86_64-linux.iso" "$iso"
}

# Create new virtualbox machine
vboxmanage createvm --name "victim" --ostype "Linux_64" --register

# Give the VM 2 CPUs
vboxmanage modifyvm "victim" --cpus 2

# Give the VM 4GB of RAM
vboxmanage modifyvm "victim" --memory 4096

# Give the VM 32MB of video memory
vboxmanage modifyvm "victim" --vram 32

# Find name of network adapter for host
$networkAdapter =  Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | Where-Object {$_.InterfaceDescription -ne 'VirtualBox Host-Only Ethernet Adapter'} | Select-Object -ExpandProperty InterfaceDescription -First 1

Write-Host "Network adapter: $networkAdapter"

# Find name of main network adapter for host
vboxmanage list hostonlyifs

# Create a bridged network adapter
vboxmanage modifyvm "victim" --nic1 bridged --bridgeadapter1 "$networkAdapter"

# Create a hard drive
vboxmanage createhd --filename "$hdd" --size 10000 --variant standard

vboxmanage storagectl "victim" --name "SATA Controller" --add sata --bootable on

# attach the hard drive to the VM
vboxmanage storageattach "victim" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$hdd"

vboxmanage storagectl "victim" --name "IDE Controller" --add ide

vboxmanage storageattach "victim" --storagectl "IDE Controller"  --port 0  --device 0 --type dvddrive --medium "$iso"

# Attempt unattended installation
vboxmanage unattended install "victim" --iso="$iso" --user="victim" --password="victim" --full-user-name="Victor Tim" --install-additions --country=DE --time-zone=UTC --hostname="victim" --language=de_DE --keyboard-layout=de --no-install-recommends #--post-install-template="$workingDir\post-install.sh"

vboxmanage startvm "victim"
