requires 'Term::EditLine', '0.05';
requires 'Term::ReadLine', '1.10';
requires 'perl', '5.008005';

on build => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Requires';
};
