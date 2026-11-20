Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193468;
	b=QtPGDxX0ruXdYMX2gl+ubIW6/mKCMN2TRt6VWZa3oCS1qxEl5ZJ9dAFrJxyxjdqbKrqj
	 7hP6qFkOgupcKkeqGPtbBd91ykBoP6iTwaml+XxEnbZgSsr7vTVhGru1bCfYjMPSnEYeU
	 Jnyi//ZDuZsIftT1OtHOIcHGYuGN+PPEbAN0JDBfHXfXzwwe0p8bN9/qYRkY7XjkWDU8p
	 V7hZ2KQ5E4awLdT0XQMyj1AToqi7i1qjtcAIbeJ2LBJS7O+HGQgfnxMLUX+UpVEr4BpoY
	 H+3p957CZ5LLIjwS8RABPyib5+2PkLT92lK80XsxJiGlZcRbq7DEW8y0jBeceF96PMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193468;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K0ndYaDZoYcWVoVC7S2A9Vrq7y6IxfYnkplM3Ym75uw=;
	b=1oVTDdhsoaSeYajKzRJSsKjH5IfXe+SouoIheOAjpyUt0oGdaa3pEleUa7j19oJWJzmp
	 SC7V2+lPUe2HrpdVFZ5xUGyRiJQ8hnesMsC/CgpbORa9yg5JeTgfCbcQRWFlfj30GPbPV
	 x/Qxm3PYhZZYrpsC3OvuPP+awTNWCeLI7jEyb6rBafSvJrh4b2yUVyAq0YVGqmIytGydD
	 KYP/TluwcorGxJ1CYz+GtI5q+x+qmxoLvCTSHp2ivoU5viARk0BURAz8h8Lt9HJZrUsTn
	 pvEtJeTRMm3pIPYtJNvYAEy/AGfjn1lyaMQeikoEoOfXT4ICPLdikhs7YWGNubDzZbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BSyJJR+c;
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93109606A334
	for <keyrings@vger.kernel.org>; Fri, 20 Nov 2026 16:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93109606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BSyJJR+c
X-Envelope-To: keyrings@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=23aotKbVmZZK5ma89rsXnDW+52IBOiyRWRcBtbK9USc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795193465; v=1; x=1795798265;
 b=BSyJJR+cYbWVVAp0IkQW1yxkmzztJIqOdC8iaxFtBLJM3P8W/dDoRWUyR1mNw8eA44LXrt89
 hUAyXI2J+U/w7r7KGlo/7W+EqJJ77QGrtVTslygiDkuQYfxmnXjpZyprjcReU6MgMn97nyANfGT
 7F6/jSWdjgQ3CjoFKh8yRuDo=
X-Envelope-To: keyrings@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f79ea2b221504db;
	Fri, 20 Nov 2026 16:51:04 +0000
X-Mizu-Trace-ID: 2f79ea2b221504db
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 16:51:05 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
 Paul Moore <paul@paul-moore.com>, Josef Bacik <josef@toxicpanda.com>
CC: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>,
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_0/3=5D_capabilities=3A_close_the?=
 =?US-ASCII?Q?_ways_around_the_CAP=5FSETFCAP_rule_for_uid_0?=
In-Reply-To: <20261120-zutun-ausgearbeitet-erregen-ebd3834404ea@brauner>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com> <20261120-zutun-ausgearbeitet-erregen-ebd3834404ea@brauner>
Message-ID: <167100D4-9E3B-4412-A554-E3D09B5BE9DA@linux.dev>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 20 November 2026 10:11:34 GMT, Christian Brauner <brauner@kernel.org>
wrote:
>On Tue, 17 Nov 2026 19:54:23 +0000, Josef Bacik wrote:
>> v1:
>https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
>> v2:
>https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/
>> v3:
>https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com/
>> v4:
>https://lore.kernel.org/all/20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com/
>> v5:
>https://lore.kernel.org/all/20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com/
>> v6:
>https://lore.kernel.org/all/20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com/
>> v7:
>https://lore.kernel.org/all/20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com/
>> v8:
>https://lore.kernel.org/all/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com/
>> v9:
>https://lore.kernel.org/all/20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com/
>> v10:
>https://lore.kernel.org/all/20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com/
>> 
>> [...]
>
>Applied to the namespace-7.5.misc branch of the vfs/vfs.git tree.
>Patches in the namespace-7.5.misc branch should appear in linux-next soon.
>
>Please report any outstanding bugs that were missed during review in a
>new review to the original patch series allowing us to drop it.
>
>It's encouraged to provide Acked-bys and Reviewed-bys even though the
>patch has now been applied. If possible patch trailers will be updated.
>
>Note that commit hashes shown below are subject to change due to rebase,
>trailer updates or similar. If in doubt, please check the listed branch.
>
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>branch: namespace-7.5.misc
>
>[1/3] userns: don't let setns() lend CAP_SETFCAP
>      https://git.kernel.org/vfs/vfs/c/711bc24f1d8f
>[2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
>      https://git.kernel.org/vfs/vfs/c/c1e5f4d36d2a
>[3/3] selftests/namespaces: test the CAP_SETFCAP rule for user namespaces
>      https://git.kernel.org/vfs/vfs/c/cbe977960cb3

Oops! Couldn't get to it. I had a look, looks ^Wsane^W

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>




>

--- Thanks!
