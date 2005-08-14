# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..10\n"; }
END {print "not ok 1\n" unless $loaded;}
use Locale::PO;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

my $po = new Locale::PO(-msgid=>'This is not a pipe',
	-msgstr=>"",
	-comment=>"The entry below is\ndesigned to test the ability of the comment fill code to properly wrap long comments as also to properly normalize the po entries. Apologies to Magritte.",
	-fuzzy=>1);
print "ok 2\n";

my $out = $po->dump;
print "ok 3\n";

my @po = $po;
$po = new Locale::PO(-msgid=>'', -msgstr=>
"Project-Id-Version: PACKAGE VERSION\\n" .
"PO-Revision-Date: YEAR-MO-DA HO:MI +ZONE\\n" .
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\\n" .
"Language-Team: LANGUAGE <LL@li.org>\\n" .
"MIME-Version: 1.0\\n" .
"Content-Type: text/plain; charset=CHARSET\\n" .
"Content-Transfer-Encoding: ENCODING\\n");
print "ok 4\n";

unshift(@po,$po);
Locale::PO->save_file_fromarray("test1.pot.out",\@po);
print "ok 5\n";

$out = `diff test1.pot test1.pot.out | grep '^[<>].*[^ ]'`;
if ($? == 0) {
  # Matches found, that's bad.
  print "not ok 6\n";
} else {
  print "ok 6\n";
  unlink "test1.pot.out";
}

my $pos = Locale::PO->load_file_asarray("test.pot");
print "ok 7\n";

$out = $pos->[0]->dump;
print "ok 8\n";

Locale::PO->save_file_fromarray("test.pot.out",$pos);
print "ok 9\n";

$out = `diff test.pot test.pot.out | grep '^[<>].*[^ ]'`;
if ($? == 0) {
  # Matches found, that's bad.
  print "not ok 10\n";
} else {
  print "ok 10\n";
  unlink "test.pot.out";
}

