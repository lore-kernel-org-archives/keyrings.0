From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 03 Feb 2020 18:18:53 +0000
Subject: [PATCH v2 1/3] common/rc: handle option with argument in _require_xfs_io_command()
Message-Id: <20200203181855.42987-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200203181855.42987-1-ebiggers@kernel.org>
In-Reply-To: <20200203181855.42987-1-ebiggers@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix _require_xfs_io_command() to handle options that take arguments when
the argument is shown in the help text.  E.g., it didn't work to run:

	_require_xfs_io_command "add_enckey" "-k"

because the relevant line of the help text is:

	-k KEY_ID -- ID of fscrypt-provisioning key containing the raw key

... but the grep command only matched "-k --", not "-k KEY_ID --".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b4a77a21..0306e93c 100644
--- a/common/rc
+++ b/common/rc
@@ -2248,7 +2248,7 @@ _require_xfs_io_command()
 	[ -n "$param" ] || return
 
 	if [ -z "$param_checked" ]; then
-		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
+		$XFS_IO_PROG -c "help $command" | grep -E -q "^ $param ([a-zA-Z_]+ )?--" || \
 			_notrun "xfs_io $command doesn't support $param"
 	else
 		# xfs_io could result in "command %c not supported" if it was
-- 
2.25.0.341.g760bfbb309-goog
