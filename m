Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082EC433B4
	for <keyrings@archiver.kernel.org>; Wed, 14 Apr 2021 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909AD613D2
	for <keyrings@archiver.kernel.org>; Wed, 14 Apr 2021 11:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbhDNLII (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Wed, 14 Apr 2021 07:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239428AbhDNLII (ORCPT <rfc822;keyrings@vger.kernel.org>);
        Wed, 14 Apr 2021 07:08:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BD1A6103D;
        Wed, 14 Apr 2021 11:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618398467;
        bh=fp4lQztsNG/Z1CQUfIxUw9+Sv3sdaVopx3+oJQp1PI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7mb4fLhexO3tpqRmWk/PqQWFURwVwFN08AAHLoYUaWG5sb5LssosCnbTBULY/MaW
         uL8Q5PHDdrrlFlGCUfVnG/UCEfaGZNx15PblylhNI7hiw55Td4coLqKxOUVj7uu2QL
         s1rUd21wp1e+t0cF/Znox/UttPff54wY0vjW2WEkYI9nAA432tNu97PknXUlLSsmVI
         afIv7tGOioWiBjFOrX0j/ylSitsd9zPRbdyxbKT9H2JxYTbFf+Cxtu58JWkZYkkXRA
         aRQslMoQRozJZjcDkOqkLatVFQXH6QssLSHOOp/RHO8I+JQfFaGp0NWeu9Rj3uzFY8
         hoCfwPeOqkcFg==
Date:   Wed, 14 Apr 2021 14:07:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KEYS: trusted: Fix missing null return from
 kzalloc call
Message-ID: <YHbNAFMdQO0/ugHE@kernel.org>
References: <20210412160101.1627882-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412160101.1627882-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Mon, Apr 12, 2021 at 05:01:01PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The kzalloc call can return null with the GFP_KERNEL flag so
> add a null check and exit via a new error exit label. Use the
> same exit error label for another error path too.
> 
> Addresses-Coverity: ("Dereference null return value")
> Fixes: 830027e2cb55 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
 
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
