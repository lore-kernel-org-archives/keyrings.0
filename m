From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:48 +0000
Subject: [PATCHv2 34/59] acpi: Remove __init from acpi table parsing functions
Message-Id: <20190731150813.26289-35-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

ACPI table parsing functions are useful after init time.

For example, the MKTME (Multi-Key Total Memory Encryption) key
service will evaluate the ACPI HMAT table when the first key
creation request occurs.  This will happen after init time.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/acpi/tables.c | 10 +++++-----
 include/linux/acpi.h  |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b32327759380..9d40af7f07fb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -33,7 +33,7 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-static int acpi_apic_instance __initdata;
+static int acpi_apic_instance;
 
 enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
@@ -49,7 +49,7 @@ struct acpi_subtable_entry {
  * Disable table checksum verification for the early stage due to the size
  * limitation of the current x86 early mapping implementation.
  */
-static bool acpi_verify_table_checksum __initdata = false;
+static bool acpi_verify_table_checksum = false;
 
 void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 {
@@ -280,7 +280,7 @@ acpi_get_subtable_type(char *id)
  * On success returns sum of all matching entries for all proc handlers.
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
-static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
+static int acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_table_header *table_header,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
@@ -355,7 +355,7 @@ static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
 	return errs ? -EINVAL : count;
 }
 
-int __init acpi_table_parse_entries_array(char *id,
+int acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
 			 struct acpi_subtable_proc *proc, int proc_num,
 			 unsigned int max_entries)
@@ -386,7 +386,7 @@ int __init acpi_table_parse_entries_array(char *id,
 	return count;
 }
 
-int __init acpi_table_parse_entries(char *id,
+int acpi_table_parse_entries(char *id,
 			unsigned long table_size,
 			int entry_id,
 			acpi_tbl_entry_handler handler,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86..fc1e7d4648bf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -228,11 +228,11 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
-int __init acpi_table_parse_entries(char *id, unsigned long table_size,
+int acpi_table_parse_entries(char *id, unsigned long table_size,
 			      int entry_id,
 			      acpi_tbl_entry_handler handler,
 			      unsigned int max_entries);
-int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
+int acpi_table_parse_entries_array(char *id, unsigned long table_size,
 			      struct acpi_subtable_proc *proc, int proc_num,
 			      unsigned int max_entries);
 int acpi_table_parse_madt(enum acpi_madt_type id,
-- 
2.21.0
