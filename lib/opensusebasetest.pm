package opensusebasetest;
use base "basetest";

# Base class for all openSUSE tests

sub pass_encrypt_check() {
    assert_screen("encrypted-disk-password-prompt");
    type_password();    # enter PW at boot
    send_key "ret";
}

1;
# vim: set sw=4 et:
