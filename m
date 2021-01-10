Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF51FC433DB
	for <keyrings@archiver.kernel.org>; Sun, 10 Jan 2021 04:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7039A22A85
	for <keyrings@archiver.kernel.org>; Sun, 10 Jan 2021 04:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAJEp4 (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Sat, 9 Jan 2021 23:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbhAJEpz (ORCPT <rfc822;keyrings@vger.kernel.org>);
        Sat, 9 Jan 2021 23:45:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60D7B22A85;
        Sun, 10 Jan 2021 04:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610253915;
        bh=NxsW+qsquAq7R6XhkIuUvATm3JptHl6Udvl+KUglLRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D88PJJGgkwpH2vcMzOcDyqvkZZ77Wf1qyN+O0SvatxPci5pIWODhrT4ocf3NX7J/d
         2rgLMqd/0GbxI9TdLEkDlI/lPxA/ztRu3uFyaOhP43D8VKwYi8XyTG1YTLQgGav/4J
         5yd2ctkrJ6i/RPyuz582c0bSrbzMseipXhe10zYgdPS76mzvg67Lm29xQpzDLLZCJq
         daUpvPOQCJJNjngn3kcqH2e2lufWblpqeicb4WLwOROiEQK+JpZNWsIXWsQdIWus6g
         /EiAKeKywezm4mdDu+BUyaJOzrQHnHIAh9/6+Fjx8DHsfLs0B2aD8Q6brG2EG5fKDF
         ndIGXtAtBKyFw==
Date:   Sun, 10 Jan 2021 06:45:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH][RESEND#15] keys: Handle missing Authority Key Identifier
 X509 extension
Message-ID: <X/qGVSXVoTeEks/j@kernel.org>
References: <20210104164048.1378237-1-andrew.zaborowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104164048.1378237-1-andrew.zaborowski@intel.com>
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Mon, Jan 04, 2021 at 05:40:47PM +0100, Andrew Zaborowski wrote:
> In a self-signed certificate the subject and issuer are the same and so
> the Authority Key Identifier X.509 v3 extension is explicitly made
> optional in RFC5280 section 4.2.1.1.
> crypto/asymmetric_keys/x509_cert_parser.c can't handle this and makes
> (at least) the restrict.c functions refuse to work with certificates
> that don't include the AKID.  Fix this by filling in the missing
> cert->sig->auth_ids with the certificate's own IDs after parsing and
> determinig the certificate is self-signed.
> 
> The asymmetric_key_generate_id return value is not checked because it's
> already succeeded once at this point.
> 
> There are root X.509 v3 certificates in use where this is the case,
> mostly oldish ones.
> 
> Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

I'll take active role with these.

I don't think that adding field data that does not exist is a great
idea.

I think that a more sane way to fix this issue, would be to add field
'self_signed' to 'struct public_key_signature', and remove the
equivalent field from 'struct x509_certificate'.

Minor updates are required to:

- x509_check_for_self_signed()
- pkcs7_verify_sig_chain()

Then you can use then new field to refine the check in
restrict_link_by_signature().

/Jarkko
