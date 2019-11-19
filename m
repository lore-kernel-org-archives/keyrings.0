From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 19 Nov 2019 22:31:29 +0000
Subject: [RFC PATCH 2/3] common/encrypt: move constant test key to common code
Message-Id: <20191119223130.228341-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191119223130.228341-1-ebiggers@kernel.org>
In-Reply-To: <20191119223130.228341-1-ebiggers@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

From: Eric Biggers <ebiggers@google.com>

For some encryption tests it's helpful to always use the same key so
that the test's output is always the same.

generic/580 already defines such a key, so move it into common/encrypt
so that other tests can use it too.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/encrypt    | 11 +++++++++++
 tests/generic/580 | 17 ++++-------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/common/encrypt b/common/encrypt
index 2e9908ad..98a407ce 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -187,6 +187,17 @@ _scratch_mkfs_stable_inodes_encrypted()
 	esac
 }
 
+# For some tests it's helpful to always use the same key so that the test's
+# output is always the same.  For this purpose the following key can be used:
+TEST_RAW_KEY+for i in {1..64}; do
+	TEST_RAW_KEY+="\\x$(printf "%02x" $i)"
+done
+# Key descriptor: arbitrary value
+TEST_KEY_DESCRIPTOR="0000111122223333"
+# Key identifier: HKDF-SHA512(key=$TEST_RAW_KEY, salt="", info="fscrypt\0\x01")
+TEST_KEY_IDENTIFIER="69b2f6edeee720cce0577937eb8a6751"
+
 # Give the invoking shell a new session keyring.  This makes any keys we add to
 # the session keyring scoped to the lifetime of the test script.
 _new_session_keyring()
diff --git a/tests/generic/580 b/tests/generic/580
index d0b0e9b3..283d6efa 100755
--- a/tests/generic/580
+++ b/tests/generic/580
@@ -43,21 +43,12 @@ _scratch_mount
 test_with_policy_version()
 {
 	local vers=$1
-	local raw_key=""
-	local i
-
-	for i in {1..64}; do
-		raw_key+="\\x$(printf "%02x" $i)"
-	done
 
 	if (( vers = 1 )); then
-		# Key descriptor: arbitrary value
-		local keyspec="0000111122223333"
+		local keyspec=$TEST_KEY_DESCRIPTOR
 		local add_enckey_args="-d $keyspec"
 	else
-		# Key identifier:
-		# HKDF-SHA512(key=raw_key, salt="", info="fscrypt\0\x01")
-		local keyspec="69b2f6edeee720cce0577937eb8a6751"
+		local keyspec=$TEST_KEY_IDENTIFIER
 		local add_enckey_args=""
 	fi
 
@@ -75,7 +66,7 @@ test_with_policy_version()
 	echo "# Getting encryption key status"
 	_enckey_status $SCRATCH_MNT $keyspec
 	echo "# Adding encryption key"
-	_add_enckey $SCRATCH_MNT "$raw_key" $add_enckey_args
+	_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY" $add_enckey_args
 	echo "# Creating encrypted file"
 	echo contents > $dir/file
 	echo "# Getting encryption key status"
@@ -90,7 +81,7 @@ test_with_policy_version()
 
 	# Test removing key with a file open.
 	echo "# Re-adding encryption key"
-	_add_enckey $SCRATCH_MNT "$raw_key" $add_enckey_args
+	_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY" $add_enckey_args
 	echo "# Creating another encrypted file"
 	echo foo > $dir/file2
 	echo "# Removing key while an encrypted file is open"
-- 
2.24.0.432.g9d3f5f5b63-goog
