Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1531E821
	for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006610; cv=none; b=DabSaIKHgBeeWQDLTG6iFsOxCIvJgcG3Igyc8UgCaZipDYV1EO39u/JBBKPmiWB1pbjfX6MiFWwmxkypj1iN8mj7TT6dW6uJuWt/jD6LiqeI0Ub5iyqQEi8ASc4zRE3lFiNepmFKwcOTnk60zvopEcy6PO9jboteqc1NlMJ8ZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006610; c=relaxed/simple;
	bh=/5nII9hAzPmxBBZ1IvEV/9Qdq0kNnpt8n1fJ6pQ7dc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/BwvdVrb6GmbH72u3icJEhOLmzZebUCWpdOdGoHi1KqbUpFpD2Do/Q4ffz+v8LO200846nNM73DFvGRQtpSm4Hy6bAwFqPtipEqOmsDjmsvFVgdMMT67BGZu7WneCBReN5caLJTECIFkt5inc4p2BTy6b7akpiKmNXlPwNKFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=r0HoDAx+; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="r0HoDAx+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/5nII9hAzPmxBBZ1IvEV/9Qdq0kNnpt8n1fJ6pQ7dc0=; b=r0HoDAx+kcocz5jDCPCZ9yYSom
	OLad/2PFEt5jMJgKPFjC6gyv5YzXRBeIg+Gwy9jCL3Adk5jZwSjy6puhy9WEIWvCHj8NNY0TxucQ6
	YsnT0GbB3RlTqQcTmofeZSLQ2auH47Vrp5UHelkbH64y+tyfdGn83JTLAd8MnrTjJVEmfOcOjThIl
	TQHWYzP7UGeVic/y4SJ7Sdi+rkICBdu8ZcS7gVgAqKAIC+E8jUnI/rwv4D3CcQqgvYeqZiOPYJGpV
	t1z5NjARUMYXw8ldCq2Bd/WA7JeVlCruLV5CHff6sKXnk3o9Gqwgm5MV5Fl/UO/Agq5hjgR6Sieuu
	5jIzuQcg==;
Received: from [207.189.26.187] (port=62995)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVc8-0000000FwZH-16zs
	for keyrings@vger.kernel.org;
	Tue, 14 Jul 2026 12:23:27 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: keyrings@vger.kernel.org
Subject: Dear keyrings@vger.kernel.org, 
Date: 14 Jul 2026 00:23:24 -0500
Message-ID: <20260714002324.20B80E0658173974@inbox.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day keyrings,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


