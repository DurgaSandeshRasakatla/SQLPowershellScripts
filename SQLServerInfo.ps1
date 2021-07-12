<###########################################################################
# 																	
# Author       : DurgaSandesh R									
# Date         : 31st August 2020									
# Version      : 1.0												
# Desctiption  : This utility will help to retrieve SQL Server information.
# Steps to Run
# 1) Populate the serverlist.txt file with hostnames or ip's of SQL servers in the environment or you can run on each individual VM,
# 2) Open the script in Powershell, run this command from centralized server from where multiples SQL servers are accessable,
# 3) Type the command Powershell C:\Data\SQLServerInfo.ps1 C:\Data\ServerList.txt C:\Data\Output.html
# 4) Check the output file generated.
# 
#																	

###########################################################################>

param(
	[string]$InputFile,
	[string]$OutputFile
)

$ServerListFile = $InputFile
$OutputFile = $OutputFile

$ServerList = Get-Content $ServerListFile -ErrorAction SilentlyContinue

[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")

$Result = @()
Foreach($SQLServer in $ServerList)
{
	$SQLServerInfo = new-object “Microsoft.SqlServer.Management.Smo.Server” $SQLServer 

 

	$Result += $SQLServerInfo | Select Name, Edition, Version, Product, ProductLevel, VersionString, ServerType, Platform, IsClustered, ClusterQuorumType, 
PhysicalMemory, Processors, Collation, IsCaseSensitive, IsFullTextInstalled, LoginMode, IsSingleUser, MasterDBLogPath, 
MasterDBPath, BackupDirectory, Databases, ComputerNamePhysicalNetBIOS, Configuration, CryptographicProviders, Endpoints, HadrManagerStatus, InstallDataDirectory, 
InstallSharedDirectory, InstanceName, Logins, LinkedServers, OSVersion, IsHadrEnabled, ServiceAccount, MasterKey, SqlDomainGroup, Triggers


}

if($Result -ne $null)
{
	$HTML = '<style type="text/css">
	#Header{font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;width:100%;border-collapse:collapse;}
	#Header td, #Header th {font-size:14px;border:1px solid #98bf21;padding:3px 7px 2px 7px;}
	#Header th {font-size:14px;text-align:left;padding-top:5px;padding-bottom:4px;background-color:#A7C942;color:#fff;}
	#Header tr.alt td {color:#000;background-color:#EAF2D3;}
	</Style>'

    $HTML += "<HTML><BODY><Table border=1 cellpadding=0 cellspacing=0 width=100% id=Header>
		<TR>
			<TH><B>Server Name</B></TH>
			<TH><B>Edition</B></TD>
			<TH><B>Version</B></TH>
            <TH><B>Product</B></TH>
            <TH><B>ProductLevel</B></TH>
            <TH><B>VersionString</B></TH>
			<TH><B>ServerType</B></TH>
			<TH><B>Platform</B></TH>
			<TH><B>IsClustered</B></TH>
<TH><B>ClusterQuorumType</B></TH>
			<TH><B>PhysicalMemory (MB)</B></TH>
			<TH><B>Logical Processors</B></TH>
            <TH><B>Collation</B></TH>
<TH><B>IsCaseSensitive</B></TH>
<TH><B>IsFullTextInstalled</B></TH> 
<TH><B>LoginMode</B></TH>
<TH><B>IsSingleUser</B></TH>
<TH><B>MasterDBLogPath</B></TH>
<TH><B>MasterDBPath</B></TH>
<TH><B>BackupDirectory</B></TH>
<TH><B>Databases</B></TH>
<TH><B>ComputerNamePhysicalNetBIOS</B></TH>
<TH><B>Configuration</B></TH>
<TH><B>CryptographicProviders</B></TH>
<TH><B>Endpoints</B></TH>
<TH><B>HadrManagerStatus</B></TH>
<TH><B>InstallDataDirectory</B></TH>
<TH><B>InstallSharedDirectory</B></TH>
<TH><B>InstanceName</B></TH>
<TH><B>Logins</B></TH>
<TH><B>LinkedServers</B></TH>
<TH><B>OSVersion</B></TH>
<TH><B>IsHadrEnabled</B></TH>
<TH><B>ServiceAccount</B></TH>
<TH><B>MasterKey</B></TH>
<TH><B>SqlDomainGroup</B></TH>
<TH><B>Triggers</B></TH>




		</TR>"
    Foreach($Entry in $Result)
    {
        $HTML += "<TR>
						<TD>$($Entry.Name)</TD>
						<TD>$($Entry.Edition)</TD>
						<TD>$($Entry.Version)</TD>
<TD align=center>$($Entry.Product)</TD>
<TD align=center>$($Entry.ProductLevel)</TD>
<TD align=center>$($Entry.VersionString)</TD>
						<TD>$($Entry.ServerType)</TD>
						<TD>$($Entry.Platform)</TD>
						<TD align=center>$($Entry.IsClustered)</TD>
<TD align=center>$($Entry.ClusterQuorumType)</TD>
						<TD align=center>$($Entry.PhysicalMemory)</TD>
						<TD align=center>$($Entry.Processors)</TD>
<TD align=center>$($Entry.Collation)</TD>
<TD align=center>$($Entry.IsCaseSensitive)</TD>
<TD align=center>$($Entry.IsFullTextInstalled)</TD>
<TD align=center>$($Entry.LoginMode)</TD>
<TD align=center>$($Entry.IsSingleUser)</TD>
<TD align=center>$($Entry.MasterDBLogPath)</TD>
<TD align=center>$($Entry.MasterDBPath)</TD>
<TD align=center>$($Entry.BackupDirectory)</TD>
<TD align=center>$($Entry.Databases)</TD>
<TD align=center>$($Entry.ComputerNamePhysicalNetBIOS)</TD>
<TD align=center>$($Entry.Configuration)</TD>
<TD align=center>$($Entry.CryptographicProviders)</TD>
<TD align=center>$($Entry.Endpoints)</TD>
<TD align=center>$($Entry.HadrManagerStatus)</TD>
<TD align=center>$($Entry.InstallDataDirectory)</TD>
<TD align=center>$($Entry.InstallSharedDirectory)</TD>
<TD align=center>$($Entry.InstanceName)</TD>
<TD align=center>$($Entry.Logins)</TD>
<TD align=center>$($Entry.LinkedServers)</TD>
<TD align=center>$($Entry.OSVersion)</TD>
<TD align=center>$($Entry.IsHadrEnabled)</TD>
<TD align=center>$($Entry.ServiceAccount)</TD>
<TD align=center>$($Entry.MasterKey)</TD>
<TD align=center>$($Entry.SqlDomainGroup)</TD>
<TD align=center>$($Entry.Triggers)</TD>





					</TR>"
    }
    $HTML += "</Table></BODY></HTML>"

	$HTML | Out-File $OutputFile
}