#
#  Copyright 2015 Electric Cloud, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

##########################
# setTimelimit.pl
##########################
use strict;
use warnings;
use ElectricCommander;

use constant {
	FALSE  => 0,
	TRUE   => 1,
	
	DEFAULT_TIMEOUT => '',
	DEFAULT_TIMEOUT_LOCATION => '/myCall/step_timelimit',
};

my $timelimit = "$[job_step_timeout]";

if (!defined($timelimit) or !isNumber($timelimit) or $timelimit <= 0) {
	$timelimit = DEFAULT_TIMEOUT;
}

my $ec = new ElectricCommander();
$ec->abortOnError(0);
my $setResult = $ec->setProperty(DEFAULT_TIMEOUT_LOCATION, $timelimit);

if ($setResult eq '') {
	print "An error occured when setting timeout to step\n";
} else {
	if ($timelimit eq '') {
		print "No timeout set\n";
	} else {
		print "Timeout set to $timelimit minute(s)\n";
	}
}

###############################
# isNumber - Determine if a variable is a number or not
#
# Arguments:
#   var
#
# Returns:
#   1 if true, 0 false
#
################################
sub isNumber {
	my ($var) = @_;
	if ($var =~ /^[+-]?\d+$/ ) {
    	return TRUE;
	} else {
	    return FALSE;
	}	
}
