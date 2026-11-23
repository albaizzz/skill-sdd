# SDD SKILL

Toolkit for Specification-Driven Development across AI coding agents. **People author the feature specification and task plan; AI validates them and implements only approved tasks.**

## Alur kerja

```text
foundation-gate
  → human authors 13-point spec with sdd-specify
  → AI validates and reports gaps
  → human approves spec
  → human authors task plan
  → sdd-task validates the plan
  → human approves task plan
  → AI executes approved tasks, one at a time
  → verification against the spec and task DoD
```

| Skill | Tanggung jawab |
|---|---|
| `foundation-gate` | Memastikan `PRD.md`, `DESIGN_SYSTEM.md`, `ARCHITECTURE.md`, dan `AGENTS.md` memberi AI konteks proyek. |
| `sdd-specify` | Memandu manusia menulis spec 13 poin. AI hanya memeriksa kelengkapan dan melaporkan gap; tidak menulis atau mengubah 13 poin. |
| `sdd-task` | Manusia menulis `docs/tasks/<ticket-id>.md`; AI memvalidasi task terhadap spec yang disetujui, tanpa mengubah dokumen. |

AI boleh menambahkan appendix terpisah **AI Agent Advisor** pada spec jika diminta. Appendix berisi rekomendasi non-binding dan tidak mengubah isi 13 poin. Hanya manusia yang menyetujui spec dan task plan.

## Install

### GitHub CLI — pilih platform

Dengan versi GitHub CLI yang menyediakan `gh skill`, pasang skills ke repository aktif:

```bash
gh skill install albaizzz/sdd-skill --all --agent opencode
gh skill install albaizzz/sdd-skill --all --agent codex
gh skill install albaizzz/sdd-skill --all --agent github-copilot
gh skill install albaizzz/sdd-skill --all --agent claude-code
```

Jalankan perintah untuk platform yang digunakan. GitHub CLI memilih lokasi skill native platform tersebut.

### Plugin native

**GitHub Copilot CLI**

```bash
copilot plugin install albaizzz/sdd-skill
```

Untuk memuat plugin dari clone lokal:

```bash
copilot --plugin-dir /path/to/sdd-skill
```

**Claude Code**

```bash
claude plugin marketplace add albaizzz/sdd-skill
claude plugin install sdd@sdd-skill
```

### Install skills dan entry-point docs ke target repository

Tanpa clone:

```bash
curl -fsSL https://raw.githubusercontent.com/albaizzz/sdd-skill/main/install.sh | bash -s -- /path/to/your/repo
```

Dari clone:

```bash
./install-foundation.sh /path/to/your/repo
```

Installer menyalin skills ke `.agents/skills/` (Codex dan GitHub Copilot), `.opencode/skills/`, dan `.claude/skills/`, serta memasang `AGENTS.md`, `CLAUDE.md`, dan `.github/copilot-instructions.md`. Skill plugin juga tersedia dari direktori `skills/` pada repository ini. Jika file instruksi target sudah berisi aturan SDD, installer mempertahankannya; periksa dan gabungkan aturan baru bila instruksinya masih memakai alur lama.

## Mulai menggunakan

1. Jalankan `foundation-gate` untuk memeriksa dokumen konteks proyek. Jika ada yang kurang, jawab wawancara agar dokumen foundation dapat dilengkapi.
2. Buat spec di `docs/specs/<ticket-id>.md`. Gunakan `sdd-specify` untuk menjawab pertanyaan per bagian dan memeriksa gap; tulis sendiri seluruh isi 13 poin.
3. Minta `sdd-specify` memvalidasi spec. Perbaiki sendiri gap yang dilaporkan, lalu minta persetujuan manusia.
4. Setelah spec disetujui, tulis task plan di `docs/tasks/<ticket-id>.md` menggunakan `TASKS.md` di folder `sdd-task/templates/` pada lokasi skill platform yang terpasang.
5. Gunakan `sdd-task` untuk memvalidasi task plan terhadap spec. Perbaiki sendiri gap-nya dan minta persetujuan manusia.
6. Minta AI mengerjakan task tertentu dari task plan yang sudah disetujui. AI mengerjakan berurutan dan memverifikasi DoD setiap task.

Contoh prompt:

```text
Gunakan foundation-gate untuk memeriksa konteks proyek ini.

Saya menulis spec di docs/specs/ORD-142.md. Gunakan sdd-specify untuk
memvalidasi kelengkapan dan melaporkan gap. Jangan ubah 13 poin saya.

Saya menulis task plan di docs/tasks/ORD-142.md. Gunakan sdd-task untuk
memvalidasinya terhadap spec yang sudah disetujui. Jangan ubah task plan.

Jalankan T1 dari task plan yang sudah disetujui dan verifikasi DoD-nya.
```

## Struktur repository

```text
skills/
├── foundation-gate/
├── sdd/
├── sdd-specify/
├── sdd-task/
│   └── templates/TASKS.md
└── spec-writer/ (legacy alias)

AGENTS.md
CLAUDE.md
.github/copilot-instructions.md
install.sh
install-foundation.sh
specs.md
```

`skills/` adalah sumber skill untuk plugin dan instalasi lintas platform. `AGENTS.md` menjadi entry point untuk Codex, OpenCode, dan GitHub Copilot; Claude Code menggunakan `CLAUDE.md`.
