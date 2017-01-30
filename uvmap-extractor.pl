#-----------------------------------------------------------------------------------------------------------------------
# uvmap-extractor.pl
#
# USAGE:
#   perl uvmap-extractor.pl <InputFile> <OutputFile>
#
# DESCRIPTION:
#   Extract UV mapping information from given .obj file and output it as JSON file.
#-----------------------------------------------------------------------------------------------------------------------
use utf8;
use JSON;
use String::Util 'trim';

# Get input .obj file path as 1st commandline parameter
my $input_file = $ARGV[0];

# Get output file path
my $output_file = $ARGV[1];

my @uv_map;
my @textures;

# Read the input file line by line
open(my $fh, '<', $input_file);
while (my $line = <$fh>) {
  my $type = substr($line, 0, 2);
  my $data = trim(substr($line, 3));
  if ($type eq 'vt') {
    my @texture = split(' ', $data);
    push(@textures, [$texture[0] + 0, $texture[1] + 0]);
  } elsif ($type eq 'f ') {
    my @uv;
    my @face = split(' ', $data);
    foreach my $vertex (@face) {
      my ($v, $vt, $vn) = split('/', $vertex);
      push(@uv, $textures[$vt - 1]);
    }
    push(@uv_map, \@uv);
  }
}
close($fh);

# Encode the UV map to JSON and save it to the input file
open(my $fh2, '>', $output_file);
print $fh2 encode_json(\@uv_map);
close($fh2);
