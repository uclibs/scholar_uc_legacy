#!/usr/bin/env perl
use strict;
use warnings;
use 5.008;
use Data::Dumper qw(Dumper);
use Switch;


#*******************************************************************************************
# 1. Locate and set $datastreamPath and $objectStorePath variables accordingly.
# 2. Create a directory where you want to export files and gets its absolute path.
# 3. Extract PIDs of the files that you intend to extract in the form sufia:9z903118b and
#       save them in a file.
#******************************************************************************************


my $datastreamPath = "/opt/rails-apps/curate_app/jetty/fedora/default/data/datastreamStore";
my $objectStorePath = "/opt/rails-apps/curate_app/jetty/fedora/default/data/objectStore";
my $PIDFile;
my $exportPath;
my %metadata;
my @script;
my $scriptName='';


print "\n\n\nIf you pass any argument to the script like 'perl exportFiles.pl jay', script will not compute checksums.\n".
      "1. Selecting option 1 to generate the export script will not export files. Only export script is generated.\n".
      "2. Option 2 will both generate export script and will export files.\n".
      "3. Option 3 will save the hash generated in this script to a file.\n\n";

print "PID file: ";
$PIDFile = <STDIN>;
chomp $PIDFile;

print "Export files to: ";
$exportPath = <STDIN>;
chomp $exportPath;


open(my $inputFile, $PIDFile) or die $!;
while(my $PID = <$inputFile>) {
    chomp $PID;
    my $cmd = 'find '.$objectStorePath.' -name "*'.(split /:/, $PID)[1].'*" -print0 | xargs -0 grep "datastreamVersion ID=\"content." | wc -l';
    chomp($metadata{$PID}{"curVer"} = (`$cmd`)-1);
    my $ver = $metadata{$PID}{"curVer"};
    while($ver >= 0) {

        $cmd = 'find '.$datastreamPath.' -name "*'.(split /:/, $PID)[1].'*content*'.$ver.'" -print';
        chomp($metadata{$PID}{"version.".$ver}{"path"} = `$cmd`);
        if(!@ARGV) {
            $cmd = 'md5sum '.`$cmd`;
            $cmd = `$cmd`;
            $cmd = (split/ /, $cmd)[0];
            chomp($metadata{$PID}{"version.".$ver}{"checksum.new"} = $cmd);
        }
        $cmd = 'find '.$datastreamPath.' -name "*'.(split /:/, $PID)[1].'*characterization*'.$ver.'" -print0 | xargs -0 grep "filename"';
        chomp($cmd = `$cmd`);
        chomp($metadata{$PID}{"version.".$ver}{"name"} = (split /</, (split />/, $cmd)[1])[0]);

        $cmd = 'find '.$datastreamPath.' -name "*'.(split /:/, $PID)[1].'*characterization*'.$ver.'" -print0 | xargs -0 grep "md5checksum"';
        chomp($cmd = `$cmd`);
        chomp($metadata{$PID}{"version.".$ver}{"checksum.old"} = (split /</, (split />/, $cmd)[1])[0]);

        $ver--;
    }
}
close $inputFile;

my $input = '';
while($input ne '4') {

    clear_screen();

    print "1. Generate export script\n".
          "2. Export files\n".
          "3. Dump hash to file\n".
          "4. exit\n";
    print ">>> ";
    $input = <STDIN>;
    chomp($input);

    switch($input) {
        case '1' {
            genScript();
        }
        case '2' {
            export();
        }
        case '3' {
            hashDump();
        }
    }
}

exit(0);

sub hashDump {
    my $fName;
    print "Save hash to: ";
    $fName = <STDIN>;
    chomp($fName);
    $fName = $exportPath.'/'.$fName;
    open(my $dump, '>>', $fName) or die $!;
    print $dump Dumper( \%metadata );
    close $dump;
}

sub clear_screen
{
    system("clear");
}

sub genScript {
    print "Save export script as[*.sh]: ";
    $scriptName = <STDIN>;
    chomp($scriptName);
    my $index = 0;
    $script[$index] = '#!'.`which sh`;
    for my $PID (keys(%metadata)) {
        $script[++$index] = 'mkdir '.$exportPath.'/'.$PID;
        my $rec = %metadata->{$PID};
        my $ver = $rec->{curVer};
        while($ver >= 0) {
            my $subrec = $rec->{'version.'.$ver};
            $script[++$index] = 'mkdir '.$exportPath.'/'.$PID.'/'.$ver;
            $script[++$index] = 'cp -p "'.$subrec->{path}.'" "'.$exportPath.'/'.$PID.'/'.$ver.'/'.$subrec->{name}.'"';
            $script[++$index] = 'echo '.$subrec->{'checksum.old'}.' >> '.$exportPath.'/'.$PID.'/'.$ver.'/oldChecksum.md5';
            if(!@ARGV) {
                $script[++$index] = 'echo '.$subrec->{'checksum.new'}.' >> '.$exportPath.'/'.$PID.'/'.$ver.'/newChecksum.md5';
            }
            $ver--;
        }
    }

    $scriptName = $exportPath.'/'.$scriptName;
    open(my $dump, '>>', $scriptName) or die $!;
    foreach(@script) {
        print $dump "$_\n";
    }
    close $dump;
}


sub export {
    my $flag;
    if($scriptName eq '') {
        $flag = 1;
    }
    if($flag){
        genScript();
    }
    my $cmd = 'sh '.$scriptName;
    `$cmd`;
}
