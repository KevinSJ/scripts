#!/usr/bin/perl 
#Provide a CSV file of old and new values, this script will 
#replace the old value with new values in the file.
#Usage: perl wsp_callGUID.pl <csv name> <file to replace>

use 5.18.0;
use warnings;
use IO::File;
use File::Basename;
main(@ARGV);

sub main
{
    my $argCount = @ARGV;
    if($argCount == 2){
        my $csvName = $ARGV[0];
        my $toReplace = $ARGV[1];
        if(-e $csvName and -e $toReplace){
            open(my $fh, "<", $csvName) 
                or die "failed to open file: $!\n";
            open(my $f, "<:unix", $toReplace)
                or die "failed to open file: $!\n";
            my $fileString= do { local($/); <$f> };
            close($f);
            while(<$fh>){
                chomp;
                $_ = lc $_;
                my @a = split(/,/,$_);
                #say foreach(@a);
                $fileString=~ s/$a[0]/$a[1]/gi;
            }
            my $filename, my $dirs, my $suffix, my @suffixes;
            ($filename,$dirs,$suffix) = fileparse($toReplace,qr/\.[^.]*/);
            my $newFilename = "new_".$filename.$suffix;
            open(my $n,'>', $newFilename);
            print $n $fileString;
            close($fh);
            close($n);
        }
    }else{
        say qq(Usage: perl wsp_callGUID.pl csv_name xsl_name)
    }
}


