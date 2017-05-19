[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation

Import-Module $PSScriptRoot\suspend-adf-pipeline.psm1
Import-Module $PSScriptRoot\ps_modules\VstsAzureHelpers_
Initialize-Azure

$resourceGroupName = Get-VstsInput -Name "resourceGroupName" -Require
$adfname = Get-VstsInput -Name "adfname" -Require
$pipelineStatus = Get-VstsInput -Name "pipelineStatus" -Require
$parallel = Get-VstsInput -Name "parallel"

$p = checkParallel -Value $parallel

$adf = getAzureDataFactory -ResourceGroupName $resourceGroupName -DataFactoryName $adfname

setPipelineStatus -DataFactory $adf -PipelineStatus $pipelineStatus -Parallel $p

Write-Host "Set pipelines to '$pipelineStatus' complete"