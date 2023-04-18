#!/usr/bin/perl
use Mojolicious::Lite -signatures;
use IPC::System::Simple qw(system capture);
use Device::VantagePro;
use Mojo::JSON qw(encode_json);
#use strict;
#use boolean;
#  +trace => [ transport => sub { print $_[1]->as_string } ];


my $wliphost = ""; 

sub GetWeather {
  my $self = shift ;

#  my $filename = '/var/DAVIS.TEMP';
#  open(FH, '<', $filename) or die $!;
#  while(<FH>){
#    my $temperature = $_;
#  }
#  close(FH);
 
  my %arg_hsh;
  $arg_hsh{host} = $wliphost;
  my $vp_obj = new Device::VantagePro(%arg_hsh);
  $vp_obj->wake_up();
  # Start loop for 2 times and read loop data
  sleep 1;

  my $hsh_ref = $vp_obj->get_one_loop();

  $self->render(json => ({conditions => $hsh_ref}));

#$self->render(json =>  
#  $self->render(data =>  $hsh_ref );
#  print Dumper $hsh_ref; # Print out data hash
  #$json = JSON->new->allow_nonref;
  #my $json = JSON->new()->encode($hsh_ref);
  #$self->render($json);
  
}


get '/' => { text => 'I get My Mojo workin' };
#192.168.30.110
get '/v1/current_conditions' => sub ($c) {
  GetWeather($c);
};

my $filename = '/deviceip';
open(FH, '<', $filename) or die $!;
while(<FH>){
  $wliphost = $_;
  }
close(FH);


app->secrets(['Mojo in mpd sta zakon']);
app->start;

__DATA__

% $c->res->code( 400 );
{ "status": "error", "error": "Bad request" }

% $c->res->code( 404 );
{ "status": "error", "error": "Bad request" }

