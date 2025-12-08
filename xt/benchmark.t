use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/../blib/lib", "$FindBin::Bin/../blib/arch";
use Test::More;

# Benchmark tests run ONLY when TEST_BENCH=1
if (!$ENV{TEST_BENCH}) {
  plan skip_all => 'Set TEST_BENCH=1 to run benchmarks';
}

eval { require Benchmark; 1 } or plan skip_all => "Benchmark module required";
Benchmark->import(':all');

eval { require Mojo::Collection; 1 } or plan skip_all => "Mojo::Collection required";

eval { require Mojo::Collection::XS; 1 } or plan skip_all => "Mojo::Collection::XS required";

diag "Running Mojo::Collection vs Mojo::Collection::XS benchmarks";
diag "Perl version: $^V";
diag "TEST_BENCH=1 → benchmark enabled";

my $SIZE = $ENV{BENCH_SIZE} || 200_000;
diag "Benchmark size: $SIZE items";

# Prepare data
my @data = (1 .. $SIZE);

my $pure = Mojo::Collection->new(@data);
my $xs   = Mojo::Collection::XS->new(@data);

# Actual benchmark
diag "Running benchmark over XS helpers: while_fast, while_ultra_fast, each_fast, map_fast, map_ultra_fast, grep_fast";

my %benchmarks = (
  pure_each_sum => sub {
    my $sum = 0;
    $pure->each(sub { $sum += $_[0] });
    return $sum;
  },
  xs_each_fast_sum => sub {
    my $sum = 0;
    $xs->each_fast(sub { $sum += $_[0] });
    return $sum;
  },
  xs_while_fast_sum => sub {
    my $sum = 0;
    $xs->while_fast(sub { $sum += $_[0] });
    return $sum;
  },
  xs_while_ultra_fast_sum => sub {
    my $sum = 0;
    $xs->while_ultra_fast(sub { my ($e) = @_; $sum += $e });
    return $sum;
  },
  pure_map_list => sub {
    my $out = $pure->map(sub { $_[0] * 2 });
    return $out->size;
  },
  xs_map_fast_list => sub {
    my $out = $xs->map_fast(sub { $_[0] * 2 });
    return $out->size;
  },
  pure_map_scalar => sub {
    my $out = $pure->map(sub { $_[0] + 1 });
    return $out->size;
  },
  xs_map_ultra_fast_scalar => sub {
    my $out = $xs->map_ultra_fast(sub { my ($e) = @_; $e + 1 });
    return $out->size;
  },
  pure_grep_even => sub {
    my $out = $pure->grep(sub { !($_[0] & 1) });
    return $out->size;
  },
  xs_grep_fast_even => sub {
    my $out = $xs->grep_fast(sub { my ($e) = @_; !($e & 1) });
    return $out->size;
  },
);

diag "Benchmarks: " . join(', ', sort keys %benchmarks);

my $results = timethese($ENV{BENCH_COUNT} || -3, \%benchmarks);

cmpthese($results);

pass "Benchmark executed successfully";

done_testing;
