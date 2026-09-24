Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF0379988;
	Thu, 24 Sep 2026 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229329; cv=none; b=cSPGzncAx+Pn2TRaYEB2jQsJWZ7wMHA6MyzRR8B+8CyKar4mO8hwSDEHzthd4zw88Dpe4OVi6RIoVVcjdTUhlPVIpolUnun5WgpEWxy1TcUsmIkynPDLj1o1P0/2zvKVX/jLnmVzjK5Dza5kViEraDl19PyBruC8kofki+XPatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229329; c=relaxed/simple;
	bh=gRac8LmOSLblikbk3GfBgKLgcjHANMhGoVl+P/q8XG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrEkFaT+CDF/E9tZe1wa1fR71l94eh34BTALEJcpvwSjguIIelq9JED071HCu9goyW+fDF/wujeOCSuB7n/iSre8FrD1pUNEwiMwQkpvRqTXnSLt24l/LgVoxopSs9LfsjWnPlhQOpzEglKy0xTARh1MsEA5BpwpiykwPvyF7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0lyvGiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0lyvGiQ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3365C1F000FF;
	Thu, 24 Sep 2026 05:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229327;
	bh=pcPUYDHn60Pmrnrn3F1Fc8Wos7/yGbcE+LNOt5OY7pA=;
	h=From:To:Cc:Subject:Date;
	b=Z0lyvGiQ+Ea+tj7KGfvH2oJplG2f0Gz1qDFIRczHCM39gGb54ah/ZmtWtuxNxn/o0
	 nAvlNRywAp8riei80DkwnItkaXCdhLCg3nktpt2/Y6G0HuvvVC7WZFqDhpn/N0D89V
	 VE4JS2GHmjoJrusEvRvlAxf8rsO2pl8/CI4S7QVw3cg28K9Flf4wdwNX1+ESbdd9iS
	 XirQf7j1gDECruJLenXlAJxMBk+BVe5T/MdLJLKriM6WKTMA3hz3zAHjxNpOOFuetL
	 pcFQm0ecwrwEouTj8Uc+fvJ3tnrMXOhz6PrvZEMihrz2yM2vdP5Xpzt1ldBWF+Qx9d
	 DyHffZ16vLw2g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [RFC PATCH 0/2] keys: Address lookup_user_key() mutability
Date: Thu, 24 Sep 2026 08:55:16 +0300
Message-ID: <20260924055521.1981957-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main objective in these patches is to remove to unneeded mutability
from key look ups. It does harm and brings no value so it is pretty obvious
to me that addressing this harmful behaviour is what we should do.

I based the first patch on what Jann suggested in [1]. Nothing too clever here
and I'm ofc open for further suggestions.

[1] https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/

Jarkko Sakkinen (2):
  keys: Return user session keyring on lookup
  keys: Reject keyring creation with overridden credentials

 Documentation/security/keys/core.rst |  7 ++-
 security/keys/process_keys.c         | 65 +++++++++++++++-------------
 2 files changed, 40 insertions(+), 32 deletions(-)

--
2.47.3

