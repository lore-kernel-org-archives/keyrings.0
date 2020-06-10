From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 10 Jun 2020 15:49:23 +0000
Subject: [PATCH 5/5] selftests: simplify kmod failure value
Message-Id: <20200610154923.27510-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com
Cc: slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org, josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, bridge@lists.linux-foundation.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>

From: Luis Chamberlain <mcgrof@kernel.org>

The "odd" 256 value was just an issue with the umh never
wrapping it around with WEXITSTATUS() for us. Now that it
does that, we can use a sane value / name for the selftest,
and this is no longer a oddity.

We add a way to detect this for older kernels, and support
the old return value for kernel code where it was given.

This never affected userspace.

Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/kmod/kmod.sh | 46 +++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index da60c3bd4f23..df7b21d8561c 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -64,6 +64,8 @@ ALL_TESTS="$ALL_TESTS 0009:150:1"
 ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
 
+MODULE_NOT_FOUND="FAILURE"
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -155,14 +157,19 @@ test_finish()
 	echo "Test completed"
 }
 
+# OLD_FAILURE is just because the old kernel umh never wrapped
+# the error with WEXITSTATUS(). Now that it does it, we get the
+# appropriate actual value from userspace observed in-kernel.
+
+# We keep the old mapping to ensure this script keeps working
+# with older kernels.
 errno_name_to_val()
 {
 	case "$1" in
-	# kmod calls modprobe and upon of a module not found
-	# modprobe returns just 1... However in the kernel we
-	# *sometimes* see 256...
-	MODULE_NOT_FOUND)
+	OLD_FAILURE)
 		echo 256;;
+	FAILURE)
+		echo 1;;
 	SUCCESS)
 		echo 0;;
 	-EPERM)
@@ -181,7 +188,9 @@ errno_name_to_val()
 errno_val_to_name()
 	case "$1" in
 	256)
-		echo MODULE_NOT_FOUND;;
+		echo OLD_FAILURE;;
+	1)
+		echo FAILURE;;
 	0)
 		echo SUCCESS;;
 	-1)
@@ -335,6 +344,28 @@ kmod_defaults_fs()
 	config_set_test_case_fs
 }
 
+check_umh()
+{
+	NAME=''
+
+	kmod_defaults_driver
+	config_num_threads 1
+	printf '\0' >"$DIR"/config_test_driver
+	config_trigger ${FUNCNAME[0]}
+	RC=$(config_get_test_result)
+	if [[ "$RC" = "256" ]]; then
+		MODULE_NOT_FOUND="OLD_FAILURE"
+		echo "check_umh: you have and old umh which didn't wrap errors"
+		echo "           with WEXITSTATUS(). This is OK!"
+	elif [[ "$RC" != "1" ]]; then
+		echo "check_umh: Unexpected return value with no modprobe argument: $RC"
+		exit
+	else
+		echo "check_umh: You have a new umh which wraps erros with"
+		echo "           WEXITSTATUS(). This is OK!"
+	fi
+}
+
 kmod_test_0001_driver()
 {
 	NAME='\000'
@@ -343,7 +374,7 @@ kmod_test_0001_driver()
 	config_num_threads 1
 	printf $NAME >"$DIR"/config_test_driver
 	config_trigger ${FUNCNAME[0]}
-	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
+	config_expect_result ${FUNCNAME[0]} $MODULE_NOT_FOUND
 }
 
 kmod_test_0001_fs()
@@ -371,7 +402,7 @@ kmod_test_0002_driver()
 	config_set_driver $NAME
 	config_num_threads 1
 	config_trigger ${FUNCNAME[0]}
-	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
+	config_expect_result ${FUNCNAME[0]} $MODULE_NOT_FOUND
 }
 
 kmod_test_0002_fs()
@@ -648,6 +679,7 @@ load_req_mod
 MODPROBE=$(</proc/sys/kernel/modprobe)
 trap "test_finish" EXIT
 
+check_umh
 parse_args $@
 
 exit 0
-- 
2.26.2
