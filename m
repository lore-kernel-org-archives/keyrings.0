Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793876;
	b=gMsXy8A+cgm6DiGExmSEDrLzfsW6oUU498WUv371HMgLwh75fzvM+fk6iJCqtZkAtmXp
	 5KE3yOXADkRyYQ6MSv0C27V6uVg4ys9MIt2ovIdBG2+OnL0bw00n6uLd/FD6ymrvlyvh9
	 rWlHi1HqychmPbR8bmbVOaUMxdoGVxrv7gSM9kYdKeiNCmaUdW1a2eDYPKSrUQKLExeFV
	 21VuFlfuON5+rfB4IcOICXCctU++pxNUO1yy+jXr8E4tMCth319IHeeaB7mTuapnF1hza
	 yPiB633XBLDcVrp1IIY1c73wMU+2nq5Iwk5rtEE4zqsNN94xomFLARgV4HhT8IqCWpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793876;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=NXv6ov7j2JUiAHmIY3+LWvm5ECdzsKbptyp8TPWwrdU=;
	b=YhQvdwFEDdJLUNtBXZeJF0jMzVOaYq7g7wtQ9M2jypm8xuy2uMYyMJsrKHHs/368zEWN
	 sZtZ06qsQmYsy+WVV5N018fHk9OQdCcbhu90XXhZaozrRc+UfuhQjI79j+tNUxDK2Ab3j
	 siVZjV+eRyvgbrJ8DZR4rhlmWvKd6pUPogHS6MvcMDnpZ+KmFAX6ULtIy4ud+/YPztaBZ
	 uxfyv7UEuEF7xxGIKqt9SCfqR8BWIlpb3IYT2BGldDcq6Tp80TqrPeb7K1qFG0FLG8AVK
	 7uhr6Xzmr7z/OOHHw4GFDUdL9iBnA0bteAz6g8BWU0As+bVFIOVaWruNFotnJ6t1n/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WYsw0Dbw;
	arc=none smtp.remote-ip=43.163.128.50
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA075606A324
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 15:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA075606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WYsw0Dbw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795793866; bh=NXv6ov7j2JUiAHmIY3+LWvm5ECdzsKbptyp8TPWwrdU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=WYsw0DbwjFVM37DKk+/0+UM+J/o6vAOe76tTMmwKOMcr3Lk1DH3vMAxfOaMnp8Jqp
	 /tPeJvl/PY5bRbQgPIVvaz6cUnM+Wm7F31MYpkfqX/ysKJDR97nfCZnaCMVBqT3hMo
	 v2rx/xVgQxqsoSeq1dhR+6LfoMKfeWPtu5r6KfLw=
Received: from [172.16.4.32] ([2408:8221:620:8610:f181:7ac4:be13:908a])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 96BB2A99; Fri, 27 Nov 2026 23:37:43 +0800
X-QQ-mid: xmsmtpt1795793863tbqan0yhq
Message-ID: <tencent_C034D5DE2B0C7E55AA5B66100D8BD7F0A805@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7VaHEW6e3R1oabCBUiuYIh1NSW529zMnOtBiCCcwB11XB7TGetL
	 P7K3IdNJpoNa+cg9W1dubmcCOahTFXzKOSznjeuDDt6hCjCdolJmvtlkJEKAYmPrUCHmrf5Yh6TE
	 V5g9X426dbbh3V4cxnQXUAbDOyx+dBWtkz8eYkrccsR489DFE98ztM2W9zhX7UBdbS3+54WmiqSO
	 r0KP0CjjkMxw3mXmg2Vgz67hBxVG+fQp2MKYesEKjuOmO/Mq+GdOORvznIYfdo1boTZubr23M0qq
	 EPeIJQiBMDI2CNGDCI17tOHmzmfGP+2KzewMbf3rWocE+N4zvlliVyjBG9xXJpxZ6b4rPSNXyn7g
	 hPV1GpkgpfZq/lDPqr1E7CN6zhNRM65wveIDk5v0aKDHUKgHfeQqu+MNE6MkrgeuM0tZ29l0yUnR
	 rSu3VP8rZnEPPHPhLXJ9Tsl9mBCBQSBfXtLH0B2mBKEovYd7bzsHgS2pI6NzgD0oVXcnOvvy+7TD
	 aP5JbWDfAwkwI036q9Kw0sYv28wOAF7jUr3A94ZdPWgQp9zkCExTz8vhlpW5XCrYXT2DggSMQPVA
	 LAre8rdP1Ow4aQOQ3BiHFrB02zr6cGOu6+tK1nxFVqknQNsJZwtOpkLDm8zDfEEj5/tM9k0OsdDD
	 HAHwtabBSartjfvgDnn8JP8QfopzcnkAv8xCUIPDuLzvOZNphbJCY3GjZF15DxrA5+OhfUeygTUb
	 3szR2FFgFpZhpOyRY3RSBwQVLwzh9p1HG3QdADxl/1B3kYPUx/dWx0XkK3E2gENP3mZiFfbVf+Zu
	 ISGYiTPSXdAE/WChUL5HhxLjv5nXPnmnbcX+ZHOWKol9xPz3nhwrNrdw73BlYJiDwUWgmNO5lF98
	 aUpWkXUjiCK5+F+32w9pqmQT2H1uoXU4Xikudky3Ev/Gq9042pu+Y4hzi9M4okb9BvZna6m2fkvF
	 ex9RgrdlvCuMKE7D4mJ1o08AfDLlrKOjInKX1Ze1F2o5iB6ihouq8GKzhM1mzvGhxD/YjNxiz84l
	 eTu1CvgLM+ULLGYJS/RBnRGbBxjbF36S3ULElBK/mYJZvtlIGQwumFg1mtNeQf7t0x+gzLLV3W2p
	 5FhJ7l
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Chenshuo Zhang <abc0eichs@qq.com>
To: keyrings@vger.kernel.org
Subject: Re: [PATCH] lib/asn1_encoder: fix encoding of zero OID components
Date: Fri, 27 Nov 2026 23:32:01 +0800
X-OQ-MSGID: <179579352165.33824.14338351702927865179@qq.com>
In-Reply-To: <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
References: <tencent_AFE15D698FFD4F18E16A6EF7CDA002D69806@qq.com>
 <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

> So for now I'll rewrite this as From:me and Reported-by:zzz.

Thanks, Andrew. Please use Chenshuo Zhang for the patch attribution.

I tested James's suggestion to share the final-octet path for
single-octet subidentifiers. The UML KUnit tests and the x86_64 W=1
build passed. Would you prefer a v2 to replace the queued patch,
or a follow-up patch?

Signed-off-by: Chenshuo Zhang <abc0eichs@qq.com>

