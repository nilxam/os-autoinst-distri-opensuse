# SUSE's openQA tests
#
# Copyright © 2009-2013 Bernhard M. Wiedemann
# Copyright © 2012-2016 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

use base "consoletest";
use testapi;

sub run() {
    my $self = shift;

    become_root;
    # non-NET installs have only milestone repo, which might be incompatible.
    my $repourl = 'http://' . get_var("SUSEMIRROR");
    unless (get_var("FULLURL")) {
        $repourl = $repourl . "/repo/oss";
    }
    type_string "zypper ar -c $repourl Factory; echo zypper-ar-done-\$? > /dev/$serialdev\n";
    wait_serial("zypper-ar-done-0") || die "zypper ar failed";
    type_string "zypper lr\n";
    assert_screen "addn-repos-listed";

    type_string "exit\n";
}

sub test_flags() {
    return {important => 1,};
}

1;
# vim: set sw=4 et:
