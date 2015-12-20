#!/usr/bin/perl

my @caches = qw /193.206.139.45 193.206.140.45/;

my $REGEX='^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^ ]*) +\S*)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^"]*)" "(?<agent>[^"]*)")? RTT (?<rtt>[0-9]+) (?<as>AS[0-9]+)$';

#my $esclusioni = '/ubuntu/|/freerainbowtables/';
my $esclusioni = '';

select STDIN; $|=1; 
select STDOUT; $|=1;

while (<>) {
  chomp;

  # match regex to extract data
  if  ($_ =~ m/$REGEX/) {
  ($host,$code,$size,$path,$as) = ($+{host},$+{code},$+{size},$+{path},$+{as});
  next if $path =~ m/$esclusioni/;
  # do not consider caches
  next if $host ~~ @caches; 
  next if $code !~ m/^20|^30/;
  $path =~ m!(/[^/]+/[^/]+)/?!;
  $subpath=$1;
  printf("%s %s %s %s\n",$code,$size, $subpath,$as);

}
}
