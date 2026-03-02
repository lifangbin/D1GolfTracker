# D1 Golf Scholarship Tracker — Product Design Document v2

**Version:** 2.0  
**Date:** February 2026  
**Author:** FB  
**Status:** Draft  

---

## 1. Product Vision

A native mobile application that tracks a junior golfer's 8-year development journey toward earning an NCAA Division 1 women's golf scholarship. The app integrates with Golf Australia's national handicapping system (GA CONNECT via golf.com.au) and external golf course databases to provide automated, data-driven tracking of player performance. Initially built for personal/family use, the architecture supports future expansion to public registration as a multi-tenant SaaS product for the junior golf community.

### 1.1 Target Users

**Phase 1 — Personal Use:**

| User | Role |
|------|------|
| Parent/Guardian | Primary user — logs data, monitors progress, manages recruiting pipeline |
| Player | Views own progress, logs practice and rounds |

**Phase 2 — Public Registration (Future):**

| User | Role |
|------|------|
| Family Account | Parent + player(s), each family is a tenant |
| Coach | Invited by family, read/write training plans, review stats |
| Tour Organiser | Publish events, bulk import results (e.g. JNJG, Golf Australia) |
| College Recruiter | View shared player profiles (opt-in export) |

### 1.2 Core Value Proposition

- **Single source of truth** for the entire D1 pathway — handicap, tournaments, training, academics, and recruiting
- **Automated handicap sync** with Golf Australia's official system via golf.com.au
- **Course auto-load** from GolfAPI.io with full scorecard context (par, slope, rating, yardage per hole)
- **Rich media capture** — photos and videos attached to every tournament round for swing analysis, highlight reels, and recruiting portfolios
- **Performance analytics** beyond simple scores — trends, strengths, and areas for improvement at hole-by-hole level
- **Future-proof architecture** — personal app today, public SaaS platform tomorrow

---

## 2. Technology Decision: Why Flutter

### 2.1 Framework Comparison (February 2026)

| Criteria | Flutter | React Native | Kotlin Multiplatform |
|----------|---------|-------------|---------------------|
| **Market Share (2026)** | ~46% | ~35% | ~23% |
| **Language** | Dart | JavaScript/TypeScript | Kotlin |
| **UI Consistency** | Pixel-perfect (custom renderer) | Native components | Native UI per platform |
| **Performance** | Near-native (AOT compiled, Impeller engine) | Good (Hermes engine, New Architecture) | Native-level |
| **Media Handling** | Excellent (image_picker, video_player, camera) | Good (react-native-image-picker) | Good (platform-specific) |
| **Supabase SDK** | Official supabase_flutter | Official supabase-js | Community Kotlin SDK |
| **Hot Reload** | Yes (fastest iteration) | Yes | Limited |
| **Single Codebase** | iOS + Android + Web + Desktop | iOS + Android (web via Expo) | Shared logic only (or Compose MP) |
| **Learning Curve** | Moderate (Dart is easy to learn) | Low (if JS/React background) | Moderate-High |
| **AI Tooling Support** | Strong (Dart well-supported by Copilot, Claude) | Strongest (JS ecosystem) | Growing |
| **App Store Deployment** | Mature | Mature | Mature |
| **Offline Support** | Excellent (Hive, Isar, sqflite) | Good | Good |

### 2.2 Recommendation: Flutter (Dart)

**Flutter is the recommended framework** for this project based on the following rationale:

**Why Flutter wins for this project:**

1. **Best media handling** — Flutter has mature, well-tested libraries for camera capture, photo/video gallery, image compression, video thumbnails, and video playback. The `image_picker`, `camera`, `video_compress`, and `chewie` packages provide a complete media pipeline out of the box.

2. **Pixel-perfect UI across platforms** — Flutter's custom rendering engine (Impeller) draws every pixel, ensuring the same polished experience on both iOS and Android without platform-specific UI quirks. Critical for a consumer app that may go public.

3. **Single codebase for future expansion** — Flutter compiles to iOS, Android, Web, and Desktop from one codebase. When the app goes public, a web dashboard for coaches/recruiters can be built from the same code.

4. **Performance** — Flutter compiles Dart to native ARM code ahead-of-time (AOT). No JavaScript bridge, no runtime interpretation. Delivers consistent 60/120 FPS even with complex charts and media galleries.

5. **Supabase first-class support** — Official `supabase_flutter` SDK with full support for auth, database, storage (file upload), edge functions, and real-time subscriptions. Photo/video upload to Supabase Storage is well-documented and battle-tested.

6. **Fastest development velocity** — Hot reload, widget-based architecture, and excellent DevTools mean rapid iteration. Critical for a solo developer building for personal use first.

7. **Mature ecosystem** — Flutter's package ecosystem covers every need: charts (`fl_chart`, `syncfusion_flutter_charts`), PDF generation, data export, offline storage, push notifications.

8. **Future-proof** — Flutter 3.38+ (2026) includes 16KB page size support for Android 15, iOS UIScene lifecycle for iPadOS, and null safety hardening. Google continues heavy investment.

**Where Flutter has trade-offs (acceptable for this project):**

- Dart is less common than JavaScript — mitigated by strong AI tooling support and growing community
- Larger app binary size (~15-20MB) — acceptable for a feature-rich app
- Web performance not as fast as native web frameworks — acceptable as web is secondary target

### 2.3 Development Environment

| Tool | Purpose |
|------|---------|
| Flutter SDK 3.38+ | Framework |
| Dart 3.7+ | Language |
| Android Studio / VS Code | IDE (Flutter plugins) |
| Xcode 16+ | iOS builds |
| Supabase CLI | Backend management |
| GitHub + GitHub Actions | Version control + CI/CD |
| Firebase App Distribution | Beta testing |
| TestFlight (iOS) / Internal Testing (Android) | App store testing |

---

## 3. System Architecture

### 3.1 Architecture Overview

```
┌──────────────────────────────────────────────────────────────┐
│                   Flutter Native App (Dart)                   │
│        iOS + Android (+ Web/Desktop future)                   │
│                                                               │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────────────┐│
│  │ Handicap │ │Tournament│ │ Training │ │  Media Gallery    ││
│  │  Module  │ │  Module  │ │  Module  │ │  Photos + Videos  ││
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────────┬─────────┘│
│       │            │            │                  │          │
│  ┌────▼────────────▼────────────▼──────────────────▼────────┐│
│  │              State Management (Riverpod)                  ││
│  └────┬────────────┬────────────┬──────────────────┬────────┘│
│       │            │            │                  │          │
│  ┌────▼────────────▼────────────▼──────────────────▼────────┐│
│  │              Repository Layer (Clean Architecture)        ││
│  └────┬────────────┬────────────┬──────────────────┬────────┘│
└───────┼────────────┼────────────┼──────────────────┼─────────┘
        │            │            │                  │
   ┌────▼────┐  ┌────▼────┐ ┌────▼────┐   ┌─────────▼────────┐
   │Supabase │  │GolfAPI  │ │golf.com │   │ Supabase Storage │
   │Postgres │  │  .io    │ │  .au    │   │ (S3-compatible)  │
   │  + Auth │  │ Course  │ │GA CONN- │   │ Photos + Videos  │
   │  + RLS  │  │  Data   │ │  ECT    │   │ + Thumbnails     │
   └─────────┘  └─────────┘ └─────────┘   └──────────────────┘
```

### 3.2 Clean Architecture Layers

```
┌─────────────────────────────────────────┐
│  Presentation Layer (Flutter Widgets)    │
│  Screens, Widgets, State (Riverpod)      │
├─────────────────────────────────────────┤
│  Application Layer (Use Cases)           │
│  Business logic, orchestration           │
├─────────────────────────────────────────┤
│  Domain Layer (Entities + Interfaces)    │
│  Pure Dart models, repository contracts  │
├─────────────────────────────────────────┤
│  Data Layer (Implementations)            │
│  Supabase, GolfAPI, local cache, media   │
└─────────────────────────────────────────┘
```

This clean architecture ensures:
- Business logic is testable without Flutter/Supabase dependencies
- Data sources can be swapped (e.g., replace Supabase with Firebase) without touching UI
- Easy to add new features (recruiting module, coach collaboration) without refactoring
- Multi-tenant expansion requires changes only in the Data Layer

### 3.3 Key Flutter Packages

| Category | Package | Purpose |
|----------|---------|---------|
| **Backend** | `supabase_flutter` | Auth, DB, Storage, Realtime |
| **State** | `flutter_riverpod` | Reactive state management |
| **Navigation** | `go_router` | Declarative routing |
| **Media - Camera** | `image_picker` | Photo/video capture from camera or gallery |
| **Media - Video** | `chewie` + `video_player` | Video playback |
| **Media - Compress** | `flutter_image_compress` | Resize photos before upload |
| **Media - Thumbnails** | `video_thumbnail` | Generate video preview images |
| **Media - Cache** | `cached_network_image` | Efficient image loading with placeholder |
| **Charts** | `fl_chart` | Performance analytics visualisations |
| **Offline** | `hive` or `isar` | Local data cache for offline use |
| **HTTP** | `dio` | API calls to GolfAPI.io |
| **PDF** | `pdf` + `printing` | Export performance reports |
| **Push** | `firebase_messaging` | Notifications (milestone alerts) |
| **Permissions** | `permission_handler` | Camera, gallery, storage access |
| **Date/Time** | `intl` | Date formatting, localisation |

---

## 4. GA CONNECT / golf.com.au Integration

### 4.1 Background

Golf Australia transitioned from GOLF Link to **GA CONNECT** on October 2, 2025. The new system is accessible via:

- **Golfer Portal:** golf.com.au (web dashboard)
- **Official App:** Golf Australia Official App (iOS/Android)
- **Golf ID:** Permanent 10-digit identifier (formerly GOLF Link number) — stays with the golfer for life

GA CONNECT provides: official GA Handicap (WHS-aligned), complete scoring history, Daily Handicap calculator, score submission, performance stats (FIR, GIR, putts), and a new Consistency Factor.

### 4.2 Integration Strategy

GA CONNECT does **not** currently expose a public REST API. Three approaches in order of preference:

#### Option A: Web Scraping with WebView Auth (MVP)

```
User authenticates via golf.com.au in embedded WebView
    → App extracts session token
    → Scrapes golfer portal pages for:
        - Current GA Handicap
        - Handicap history (date + value pairs)
        - Score history (date, course, score, daily HC, PCC)
        - Round statistics (FIR, GIR, putts if available)
```

| Component | Detail |
|-----------|--------|
| Auth | In-app WebView → golf.com.au login → extract session cookie |
| Scrape Targets | `/golfer/{golfId}/handicap-history`, `/score-history` |
| Sync Frequency | On-demand (pull-to-refresh) + daily background sync |
| Fallback | Manual entry if scraping breaks |

#### Option B: LSP Partnership (Medium Term)

Apply for Licensed Software Provider status with Golf Australia to access GA CONNECT APIs directly — same integration path used by MiClub, SimpleGolf, Golf Genius, etc.

**Contact:** help@golf.com.au | Golf Australia Technology Team

#### Option C: Manual + Deep Link (Simplest Fallback)

- User enters handicap manually
- App provides deep link to golf.com.au golfer portal
- OCR capture option: screenshot handicap page → extract data via on-device ML

### 4.3 Data Points from GA CONNECT

| Field | Source | Usage |
|-------|--------|-------|
| GA Handicap Index | golf.com.au portal | Primary handicap tracking |
| Handicap History | Score history page | Trend chart, improvement rate |
| Daily Handicap | Calculated per course/tees | Adjusted scoring analysis |
| Score History | Round submissions | Auto-populate tournament records |
| PCC (Playing Conditions Calculation) | GA system | Contextualise scores by conditions |
| Consistency Factor | New WHS feature | Advanced fairness analytics |
| Round Statistics | GA App data | FIR%, GIR%, Putts per round |

### 4.4 Daily Handicap Calculation (WHS)

```
Daily Handicap = Handicap Index × (Slope Rating / 113) + (Course Rating - Par)
```

Calculated locally using course data from GolfAPI.io when GA CONNECT sync is unavailable.

---

## 5. Course Data Integration (Auto-Load)

### 5.1 Primary API: GolfAPI.io

| Feature | Detail |
|---------|--------|
| Coverage | 42,000+ courses in 100+ countries (includes Australia) |
| Data | Club info, full scorecard, par per hole, stroke indexes, multiple tee sets, slope, course rating, green coordinates |
| Format | REST API, JSON responses |
| Auth | Bearer token (API key) |

**Endpoints:**

```http
# Search Australian clubs
GET https://api.golfapi.io/clubs?country=AU&name={query}
Authorization: Bearer {API_KEY}

# Full club data with all courses
GET https://api.golfapi.io/clubs/{clubId}

# Full course data (scorecard, tees, ratings)
GET https://api.golfapi.io/courses/{courseId}
```

**Example Course Response:**
```json
{
  "courseId": "AU-NSW-00142",
  "courseName": "North Course",
  "holes": 18,
  "par": [4, 3, 5, 4, 4, 3, 4, 5, 4, 4, 3, 5, 4, 4, 3, 4, 5, 4],
  "strokeIndex": [7, 15, 3, 1, 11, 17, 9, 5, 13, 8, 16, 4, 2, 12, 18, 10, 6, 14],
  "tees": [
    {
      "teeName": "Red",
      "gender": "female",
      "totalYards": 5200,
      "courseRating": 70.2,
      "slopeRating": 125,
      "distances": [320, 145, 465, 380, 350, 140, 360, 480, 370]
    }
  ]
}
```

### 5.2 Auto-Load Flow

```
User creates new tournament round
  │
  ├─ Types club name (autocomplete search)
  │     → GolfAPI: GET /clubs?name={query}&country=AU
  │     → Display matching clubs
  │
  ├─ Selects club → loads courses
  │     → GolfAPI: GET /clubs/{id}
  │     → Show available courses + tee sets
  │
  ├─ Selects course + tees
  │     → Auto-populate per hole: par, SI, distance
  │     → Auto-populate: course rating, slope, total yardage
  │
  └─ Scorecard ready for hole-by-hole entry
```

### 5.3 Caching Strategy

| Strategy | Detail |
|----------|--------|
| Local Cache | Cache all loaded courses in Hive/Isar (offline-capable) |
| Favourites | Pin frequently played courses for instant load |
| Offline Mode | Cached courses usable without network |
| TTL | Refresh course data every 90 days |
| Pre-load | Pre-load top 50 NSW junior golf courses on first install |

### 5.4 Alternative Course APIs Evaluated

| API | AU Courses | Scorecard | Slope/Rating | Free Tier | Selected |
|-----|-----------|-----------|-------------|-----------|----------|
| **GolfAPI.io** | ✅ | ✅ Full | ✅ | Trial | ✅ Primary |
| Golf Course DB | ✅ | ✅ Basic | ✅ | No | Backup |
| Zyla Golf Courses | ✅ | ✅ Full | Partial | Trial | Evaluated |
| TeeRadar | Partial | ✅ | ✅ | No | Evaluated |
| USGA NCRDB | US only | ✗ | ✅ | Yes | ✗ |

---

## 6. Photo & Video Media System

### 6.1 Overview

Every tournament round can have photos and videos attached — capturing swing footage, course conditions, celebration moments, and hole-specific notes. This media serves dual purposes: performance analysis and building a recruiting highlight portfolio.

### 6.2 Media Data Model

```
MediaItem
├── id: UUID
├── user_id: UUID (FK → auth.users)
├── tournament_id: UUID (FK → Tournament)
├── round_id: UUID (FK → Round, nullable)
├── hole_number: int (nullable — for hole-specific media)
├── type: enum (photo | video)
├── category: enum
│     swing_front    — front-angle swing video
│     swing_side     — side-angle swing video
│     swing_dtl      — down-the-line swing video
│     course_shot    — course/scenery photo
│     scorecard      — scorecard photo
│     celebration    — trophy/podium photo
│     training       — practice session
│     other
├── caption: string
├── tags: string[]           ["driver", "iron", "putting", "hole3"]
├── storage_path: string     "media/{user_id}/{tournament_id}/{filename}"
├── thumbnail_path: string   "thumbnails/{user_id}/{tournament_id}/{filename}"
├── file_size_bytes: int
├── duration_seconds: float  (video only)
├── width: int
├── height: int
├── taken_at: timestamp
├── uploaded_at: timestamp
├── metadata: jsonb          {device, location, fps, codec}
└── is_highlight: bool       (marked for recruiting portfolio)
```

### 6.3 Media Capture & Upload Pipeline

```
┌──────────────┐     ┌──────────────┐     ┌──────────────────┐
│  Capture      │     │  Process     │     │  Upload          │
│               │     │              │     │                  │
│ Camera/Gallery│────▶│ Compress     │────▶│ Supabase Storage │
│ image_picker  │     │ + Thumbnail  │     │ (S3-compatible)  │
│               │     │ + Metadata   │     │                  │
└──────────────┘     └──────────────┘     └──────────────────┘
        │                   │                      │
        ▼                   ▼                      ▼
  User selects        Photo: resize to         Upload original
  photo or video      max 2048px, quality 85%  + thumbnail
  from camera         Video: compress to 720p  Store paths in
  or gallery          Generate thumbnail       Supabase Postgres
                      Extract EXIF metadata
```

**Photo Pipeline (Flutter):**

```dart
// 1. Capture
final image = await ImagePicker().pickImage(
  source: ImageSource.camera,  // or .gallery
  maxWidth: 2048,
  imageQuality: 85,
);

// 2. Compress + generate thumbnail
final compressed = await FlutterImageCompress.compressWithFile(
  image.path,
  quality: 85,
  minWidth: 2048,
);
final thumbnail = await FlutterImageCompress.compressWithFile(
  image.path,
  quality: 60,
  minWidth: 400,
);

// 3. Upload to Supabase Storage
final path = 'media/$userId/$tournamentId/${DateTime.now().millisecondsSinceEpoch}.jpg';
await supabase.storage.from('tournament-media').upload(path, File(image.path));
final thumbPath = 'thumbnails/$userId/$tournamentId/...';
await supabase.storage.from('tournament-media').upload(thumbPath, thumbnail);

// 4. Store metadata in Postgres
await supabase.from('media_items').insert({
  'tournament_id': tournamentId,
  'type': 'photo',
  'storage_path': path,
  'thumbnail_path': thumbPath,
  ...
});
```

**Video Pipeline (Flutter):**

```dart
// 1. Capture
final video = await ImagePicker().pickVideo(
  source: ImageSource.camera,
  maxDuration: Duration(seconds: 120),  // 2 min limit
);

// 2. Compress (background isolate)
final compressed = await VideoCompress.compressVideo(
  video.path,
  quality: VideoQuality.MediumQuality,  // 720p
  deleteOrigin: false,
);

// 3. Generate thumbnail
final thumbBytes = await VideoThumbnail.thumbnailData(
  video: video.path,
  imageFormat: ImageFormat.JPEG,
  maxWidth: 400,
  quality: 75,
);

// 4. Upload (chunked for large files)
await supabase.storage.from('tournament-media').upload(path, File(compressed.path));
```

### 6.4 Supabase Storage Configuration

```sql
-- Storage bucket for tournament media
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'tournament-media',
  'tournament-media',
  false,  -- private (use signed URLs)
  52428800,  -- 50MB per file
  ARRAY['image/jpeg', 'image/png', 'image/heic', 'video/mp4', 'video/quicktime']
);

-- RLS: Users can only access their own media
CREATE POLICY "Users access own media"
ON storage.objects FOR ALL
USING (auth.uid()::text = (storage.foldername(name))[2]);
```

**Storage Structure:**
```
tournament-media/
├── media/
│   └── {user_id}/
│       └── {tournament_id}/
│           ├── 1709012345_swing_front.mp4
│           ├── 1709012367_course.jpg
│           └── 1709012890_scorecard.jpg
└── thumbnails/
    └── {user_id}/
        └── {tournament_id}/
            ├── 1709012345_thumb.jpg
            └── 1709012367_thumb.jpg
```

### 6.5 Media Gallery UI

```
┌──────────────────────────────────────────┐
│  JNJG Under 12 Tour - Round 3           │
│  15 Mar 2026 · Manly Golf Club          │
│                                          │
│  📸 Media (8 items)                      │
│  ┌─────────────────────────────────────┐ │
│  │ [Filter: All | Swing | Course | 📋]│ │
│  ├─────────────────────────────────────┤ │
│  │ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐  │ │
│  │ │ 🎬  │ │ 📷  │ │ 📷  │ │ 🎬  │  │ │
│  │ │Swing│ │Hole3│ │Score│ │Putt │  │ │
│  │ │Front│ │Tee  │ │card │ │Drill│  │ │
│  │ │⭐   │ │     │ │     │ │⭐   │  │ │
│  │ └─────┘ └─────┘ └─────┘ └─────┘  │ │
│  │ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐  │ │
│  │ │ 📷  │ │ 📷  │ │ 🎬  │ │ 📷  │  │ │
│  │ │Green│ │Prize│ │Swing│ │Team │  │ │
│  │ │#18  │ │Give │ │Side │ │Photo│  │ │
│  │ │     │ │     │ │⭐   │ │     │  │ │
│  │ └─────┘ └─────┘ └─────┘ └─────┘  │ │
│  └─────────────────────────────────────┘ │
│                                          │
│  ⭐ = Marked as highlight (recruiting)   │
│                                          │
│  [📷 Add Photo]  [🎬 Add Video]         │
│  [📤 Export Highlights]                  │
└──────────────────────────────────────────┘
```

### 6.6 Recruiting Highlight Reel

Media marked as `is_highlight = true` are automatically aggregated into a recruiting portfolio:

| Feature | Detail |
|---------|--------|
| Highlight Gallery | All starred media across tournaments, chronological |
| Export to PDF | One-page player profile with best photos + stats |
| Share Link | Generate signed URL for coach to view highlights (time-limited) |
| Video Compilation | Future: auto-stitch highlight videos into a reel |
| Social Media | Future: export clips formatted for Instagram/YouTube Shorts |

---

## 7. Enhanced Tournament Tracking

### 7.1 Full Data Model

```
Tournament
├── id, user_id, phase (1-4)
├── name, type, format, level, organiser
├── date_start, date_end, total_holes
├── location, weather_notes
│
├── Rounds[]
│   ├── round_number, date
│   ├── course_id (FK → cached Course from GolfAPI)
│   ├── tee_id, weather, conditions
│   ├── gross_score, net_score, stableford_points
│   ├── daily_handicap, pcc_adjustment
│   │
│   ├── HoleScores[]
│   │   ├── hole_number, par (auto), si (auto), distance (auto)
│   │   ├── score, putts
│   │   ├── fairway_hit, gir, up_and_down, sand_save
│   │   ├── penalty_strokes, notes
│   │   └── media_items[] (FK → MediaItem)
│   │
│   ├── RoundStats (auto-calculated)
│   │   ├── FIR%, GIR%, putts/round, putts/GIR
│   │   ├── up_and_down%, sand_save%, scrambling%
│   │   ├── scoring avg by par 3/4/5
│   │   ├── birdies, pars, bogeys, doubles+
│   │   └── front_9 vs back_9 scores
│   │
│   └── media_items[] (round-level media)
│
├── Result
│   ├── position, field_size, position_pct
│   ├── total_gross, total_vs_par, cut_made
│   └── prize_notes
│
├── media_items[] (tournament-level media)
│
└── Course (auto-loaded from GolfAPI.io)
    ├── club_name, course_name, city, state
    ├── par_total, total_yardage
    ├── course_rating, slope_rating
    └── holes[]: { hole, par, si, distance }
```

### 7.2 Performance Analytics

**Scoring Analysis:**

| Metric | Visualisation | D1 Benchmark |
|--------|---------------|--------------|
| Scoring Average | Line chart (trend) | < 74 |
| Score vs Par | Bar chart per phase | Under par |
| Par 3/4/5 Average | Grouped bars | < 3.2 / < 4.2 / < 5.0 |
| Score Distribution | Donut (eagles→doubles) | 60%+ pars or better |
| Front 9 vs Back 9 | Split comparison | Consistent |

**Short Game & Putting:**

| Metric | D1 Benchmark |
|--------|--------------|
| Putts Per Round | < 30 |
| 1-Putt % | > 35% |
| 3-Putt Avoidance | < 3% |
| Up-and-Down % | > 55% |
| Sand Save % | > 45% |

**Ball Striking:**

| Metric | D1 Benchmark |
|--------|--------------|
| FIR % | > 70% |
| GIR % | > 60% |
| Par 5 Birdie Rate | > 30% |

**Competitive:**

| Metric | Purpose |
|--------|---------|
| Win Rate | Track competitiveness |
| Top 3 / Top 10 Rate | Podium consistency |
| Average Field Percentile | Relative performance |
| Multi-Day Trend | R1 → R2 → R3 consistency |

---

## 8. Architecture for Personal → Public Expansion

### 8.1 Multi-Tenancy Strategy

The app is designed from day one with a `user_id` foreign key on every table, enabling seamless transition to multi-tenant when public registration opens.

**Personal Use Phase (Now):**
- Single user, single Supabase project
- All data scoped by `auth.uid()`
- RLS policies enforce data isolation

**Public Registration Phase (Future):**
- Supabase Auth handles registration (email, Google, Apple Sign-In)
- Each family = one "tenant" (parent account + linked player profiles)
- RLS policies unchanged — `user_id = auth.uid()` already isolates data
- Upgrade to `family_id` for parent + player sharing within a family

### 8.2 Database Schema (Multi-Tenant Ready)

```sql
-- Core: Every table has user_id for RLS
CREATE TABLE players (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users NOT NULL,  -- owner (parent)
  family_id UUID,  -- future: family grouping
  name TEXT NOT NULL,
  date_of_birth DATE,
  golf_id TEXT,  -- GA CONNECT Golf ID
  current_handicap DECIMAL(4,1),
  current_phase INT DEFAULT 1,
  avatar_path TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS Policy: Users only see their own players
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own players"
ON players FOR ALL
USING (auth.uid() = user_id);

-- Same pattern for all tables:
-- tournaments, rounds, hole_scores, media_items,
-- training_logs, milestones, academic_records, etc.
```

### 8.3 Expansion Roadmap

```
Phase 1: Personal App (Now)
├── Single user (you)
├── Single player (your daughter)
├── All features functional
├── Supabase free tier
└── Private GitHub repo

Phase 2: Family & Coach Sharing
├── Invite coach (read-only link with signed JWT)
├── Multiple players per account (if siblings)
├── Shared dashboard view
└── Still private, invite-only

Phase 3: Public Beta (6-12 months)
├── Open registration (Supabase Auth)
├── Freemium model: Free (1 player, basic stats)
│   vs Premium ($9.99/mo: full analytics, media, recruiting)
├── App Store deployment (iOS + Android)
├── Terms of Service, Privacy Policy
├── Supabase Pro plan (~$25/mo)
└── Custom domain: d1golftracker.com.au

Phase 4: Platform (12-24 months)
├── Coach accounts with training plan creation
├── Tour organiser accounts (bulk result import)
├── Recruiter profiles (view shared player portfolios)
├── Web dashboard (Flutter Web)
├── API for third-party integrations
├── Push notifications (milestone alerts, recruiting timeline)
└── Stripe integration for subscriptions
```

### 8.4 Supabase Scaling Path

| Stage | Plan | Cost | Capacity |
|-------|------|------|----------|
| Personal | Free | $0 | 500MB DB, 1GB storage, 50K auth users |
| Early Public | Pro | $25/mo | 8GB DB, 100GB storage, unlimited auth |
| Growth | Pro + Add-ons | $50-100/mo | Larger DB, more storage, custom domains |
| Scale | Team/Enterprise | Custom | Dedicated infrastructure, SLA |

**Storage estimates for media:**

| Usage | Per User/Year | 100 Users | 1,000 Users |
|-------|---------------|-----------|-------------|
| Photos (~2MB each, 50/year) | 100MB | 10GB | 100GB |
| Videos (~20MB each, 20/year) | 400MB | 40GB | 400GB |
| Thumbnails | 10MB | 1GB | 10GB |
| **Total** | **~510MB** | **~51GB** | **~510GB** |

At 1,000 users, storage costs ~$12/mo on Supabase ($0.021/GB). Highly manageable.

---

## 9. Project Structure (Flutter)

```
lib/
├── main.dart
├── app/
│   ├── app.dart                    # MaterialApp, theme, router
│   ├── router.dart                 # GoRouter configuration
│   └── theme.dart                  # App theme (golf green + navy)
│
├── core/
│   ├── constants/                  # API keys, storage keys, phase data
│   ├── extensions/                 # Dart extensions
│   ├── utils/                      # Helpers (date formatting, WHS calc)
│   └── services/
│       ├── supabase_service.dart   # Supabase client singleton
│       ├── golf_api_service.dart   # GolfAPI.io client
│       ├── media_service.dart      # Photo/video capture + compress
│       └── ga_connect_service.dart # golf.com.au integration
│
├── features/
│   ├── auth/                       # Login, registration (future)
│   ├── dashboard/                  # Home screen, phase overview
│   ├── handicap/                   # HC tracking, GA CONNECT sync
│   ├── tournaments/
│   │   ├── data/                   # Repository impl, DTOs
│   │   ├── domain/                 # Entities, repository interface
│   │   └── presentation/
│   │       ├── screens/            # Tournament list, detail, entry
│   │       ├── widgets/            # Scorecard, stats cards
│   │       └── providers/          # Riverpod providers
│   ├── media/
│   │   ├── data/                   # Supabase storage impl
│   │   ├── domain/                 # MediaItem entity
│   │   └── presentation/
│   │       ├── screens/            # Gallery, viewer, camera
│   │       └── widgets/            # Thumbnail grid, video player
│   ├── training/                   # Training log
│   ├── milestones/                 # Phase milestones
│   ├── academic/                   # Academic records
│   ├── analytics/                  # Performance charts + benchmarks
│   ├── course_search/              # GolfAPI.io course finder
│   └── recruiting/                 # Future: school list, coach comms
│
├── shared/
│   ├── widgets/                    # Reusable widgets (buttons, cards)
│   └── models/                     # Shared data models
│
└── generated/                      # Auto-generated code (if using)
```

---

## 10. Development Roadmap

### Sprint 1-2 (Weeks 1-4): Foundation

- Flutter project setup, theme, navigation
- Supabase project + schema + RLS policies
- Auth (email/password for personal use)
- Player profile setup
- Dashboard skeleton with phase selector

### Sprint 3-4 (Weeks 5-8): Core Tracking

- Handicap module (manual entry + golf.com.au deep link)
- GolfAPI.io integration (course search + auto-load)
- Tournament entry flow (info → course → scorecard → results)
- Hole-by-hole score entry with auto-populated course data
- Basic round statistics calculation

### Sprint 5-6 (Weeks 9-12): Media & Analytics

- Photo capture + upload to Supabase Storage
- Video capture + compression + upload
- Media gallery per tournament/round
- Highlight marking for recruiting
- Performance analytics dashboard (fl_chart)
- D1 benchmark comparison view

### Sprint 7-8 (Weeks 13-16): Polish & Expand

- Milestones module (pre-loaded per phase)
- Training log
- Academic records
- Offline support (Hive cache)
- PDF export (player performance report)
- GA CONNECT handicap sync (scraping MVP)
- Bug fixes, testing, App Store prep

### Sprint 9-10 (Weeks 17-20): Public Prep (If Ready)

- Supabase Auth (email, Google, Apple Sign-In)
- Onboarding flow for new users
- Subscription / paywall (RevenueCat)
- Terms of Service, Privacy Policy
- App Store submission (iOS + Android)
- Landing page (d1golftracker.com.au)

---

## 11. Data Privacy & Compliance

| Concern | Approach |
|---------|----------|
| Junior Data | All accounts created by parent/guardian. Parental consent required. |
| Golf ID | Stored encrypted in Supabase. Never shared. |
| Media (Photos/Videos of minors) | Private by default. Signed URLs only. Never publicly indexed. Parent controls all sharing. |
| GA CONNECT Credentials | Stored in Supabase Vault. User can revoke anytime. |
| Data Ownership | Users own all data. Full export (CSV/PDF) + deletion on request. |
| Australian Privacy Act | Compliant. Data stored in Supabase Sydney region (ap-southeast-2). |
| COPPA (US) | If US users join in future: parental consent flow required. |
| App Store | Apple/Google privacy labels accurately reflect data collection. |

---

## 12. Confirmed Decisions (February 2026)

| # | Question | Decision | Rationale |
|---|----------|----------|-----------|
| 1 | GA CONNECT integration? | **WebView scraping in MVP** | Higher risk but higher value. Build as isolated module with manual fallback. |
| 2 | GolfAPI.io pricing? | **Free tier first** | Start with trial, evaluate coverage. Manual course entry as fallback. |
| 3 | Video max duration? | **120 seconds** | Swing videos need full routine. |
| 4 | Video compression quality? | **720p** | Good quality, reasonable file size (~20MB/min). |
| 5 | Offline-first or online-first? | **Online-first (nice-to-have offline)** | Simplifies MVP. Basic caching only. Full offline in Phase 2. |
| 6 | State management? | **Riverpod** | Modern, testable, less boilerplate. |
| 7 | Monetisation? | **Freemium ($9.99/mo)** | When going public. |
| 8 | App name? | To be decided | D1 Golf Tracker / GolfPath / JuniorGolfPro |
| 9 | Team size? | **Full team (4.5 FTE)** | Faster delivery, target 16 weeks. |

---

## 13. GA CONNECT Scraping Strategy & Fallback

### 13.1 Primary Flow: WebView Authentication + Scraping

```
┌──────────────────────────────────────────────────────────────────┐
│  User taps "Sync with GA CONNECT"                                │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  WebView opens golf.com.au/login                            │ │
│  │  User enters Golf ID + password                             │ │
│  │  On successful login → extract session cookie               │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                           │                                       │
│                           ▼                                       │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  Background HTTP requests with session cookie:              │ │
│  │  • GET /golfer/{id}/handicap → Current GA Handicap          │ │
│  │  • GET /golfer/{id}/handicap-history → Historical values    │ │
│  │  • GET /golfer/{id}/scores → Score history                  │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                           │                                       │
│                           ▼                                       │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  Parse HTML/JSON responses                                  │ │
│  │  Store in Supabase with sync timestamp                      │ │
│  │  Display "Last synced: [timestamp]"                         │ │
│  └─────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────┘
```

### 13.2 Fallback Scenarios

| Scenario | Detection | User Experience | Technical Response |
|----------|-----------|-----------------|-------------------|
| **Login fails** | HTTP 401/403 | "Invalid credentials. Please try again." | Clear stored session, prompt re-login |
| **Site structure changed** | Parse error / missing fields | "GA CONNECT sync unavailable. Enter manually." | Log error for dev review, enable manual mode |
| **Network error** | Timeout / no response | "Connection failed. Check internet and retry." | Retry with exponential backoff (3 attempts) |
| **Rate limited** | HTTP 429 | "Too many requests. Try again in 1 hour." | Respect rate limit, queue next sync |
| **Session expired** | HTTP 401 after initial success | "Session expired. Please log in again." | Clear session, prompt re-auth |

### 13.3 Fallback UI: Manual Handicap Entry

```
┌──────────────────────────────────────────┐
│  ⚠️ GA CONNECT Sync Unavailable          │
│                                          │
│  We couldn't sync automatically.         │
│  You can enter your handicap manually.   │
│                                          │
│  Current GA Handicap:                    │
│  ┌────────────────────────────────────┐  │
│  │  12.4                              │  │
│  └────────────────────────────────────┘  │
│                                          │
│  Last updated: [date picker]             │
│  ┌────────────────────────────────────┐  │
│  │  28 Feb 2026                       │  │
│  └────────────────────────────────────┘  │
│                                          │
│  [Save Manually]                         │
│                                          │
│  ─────────────────────────────────────   │
│  🔗 Open golf.com.au to check your       │
│     official handicap                    │
│                                          │
│  [Retry Sync]  [Open golf.com.au →]      │
└──────────────────────────────────────────┘
```

### 13.4 Scraping Module Architecture

The scraping logic is isolated in a dedicated service class to enable:
- Easy updates when site structure changes
- A/B testing between scraping versions
- Quick disable if GA issues cease-and-desist

```dart
// lib/core/services/ga_connect_service.dart

abstract class GAConnectService {
  Future<GAConnectResult> authenticate(String golfId, String password);
  Future<HandicapData?> fetchCurrentHandicap();
  Future<List<HandicapHistory>> fetchHandicapHistory();
  Future<List<ScoreRecord>> fetchScoreHistory();
  Future<void> logout();
}

class GAConnectScrapingService implements GAConnectService {
  // WebView-based implementation
  // Isolated, versioned, easily replaceable
}

class GAConnectManualService implements GAConnectService {
  // Manual entry fallback
  // Always available
}
```

---

## 14. Manual Course Entry Flow

### 14.1 When Manual Entry is Required

- GolfAPI.io doesn't have the course
- GolfAPI.io data is outdated/incorrect
- API is down or rate limited
- User is offline (future)

### 14.2 Course Search with Fallback

```
┌──────────────────────────────────────────┐
│  Search Course                           │
│  ┌────────────────────────────────────┐  │
│  │  🔍 Manly Golf Club               │  │
│  └────────────────────────────────────┘  │
│                                          │
│  Results from GolfAPI.io:                │
│  ┌────────────────────────────────────┐  │
│  │  Manly Golf Club - Championship   │  │
│  │  Manly, NSW · 18 holes · Par 72   │  │
│  └────────────────────────────────────┘  │
│  ┌────────────────────────────────────┐  │
│  │  Manly Golf Club - Executive      │  │
│  │  Manly, NSW · 9 holes · Par 32    │  │
│  └────────────────────────────────────┘  │
│                                          │
│  ─────────────────────────────────────   │
│  Can't find your course?                 │
│  [+ Add Course Manually]                 │
└──────────────────────────────────────────┘
```

### 14.3 Manual Course Entry Form

```
┌──────────────────────────────────────────┐
│  ← Add Course Manually                   │
│                                          │
│  Club Name *                             │
│  ┌────────────────────────────────────┐  │
│  │  Bayview Golf Club                 │  │
│  └────────────────────────────────────┘  │
│                                          │
│  Course Name (if multiple courses)       │
│  ┌────────────────────────────────────┐  │
│  │  Main Course                       │  │
│  └────────────────────────────────────┘  │
│                                          │
│  Location                                │
│  ┌─────────────────┐ ┌─────────────────┐ │
│  │  Bayview        │ │  NSW ▼         │ │
│  └─────────────────┘ └─────────────────┘ │
│                                          │
│  Number of Holes *    Total Par *        │
│  ┌─────────────────┐ ┌─────────────────┐ │
│  │  18 ▼           │ │  72            │ │
│  └─────────────────┘ └─────────────────┘ │
│                                          │
│  ── Tee Information ──                   │
│                                          │
│  Tee Name *           Gender *           │
│  ┌─────────────────┐ ┌─────────────────┐ │
│  │  Red            │ │  Women ▼       │ │
│  └─────────────────┘ └─────────────────┘ │
│                                          │
│  Course Rating *      Slope Rating *     │
│  ┌─────────────────┐ ┌─────────────────┐ │
│  │  70.2           │ │  125           │ │
│  └─────────────────┘ └─────────────────┘ │
│                                          │
│  Total Distance (optional)               │
│  ┌────────────────────────────────────┐  │
│  │  5200 metres                       │  │
│  └────────────────────────────────────┘  │
│                                          │
│  [Continue to Hole Setup →]              │
└──────────────────────────────────────────┘
```

### 14.4 Hole-by-Hole Setup (Optional)

```
┌──────────────────────────────────────────┐
│  ← Hole Setup (Optional)                 │
│                                          │
│  You can skip this and enter par per     │
│  hole when scoring, or set it up now.    │
│                                          │
│  ┌──────┬──────┬──────┬──────┐          │
│  │ Hole │ Par  │  SI  │ Dist │          │
│  ├──────┼──────┼──────┼──────┤          │
│  │  1   │  4 ▼ │  7   │ 320  │          │
│  │  2   │  3 ▼ │  15  │ 145  │          │
│  │  3   │  5 ▼ │  3   │ 465  │          │
│  │  4   │  4 ▼ │  1   │ 380  │          │
│  │ ...  │ ...  │ ...  │ ...  │          │
│  │  18  │  4 ▼ │  14  │ 390  │          │
│  └──────┴──────┴──────┴──────┘          │
│                                          │
│  Calculated Total: Par 72 · 5,200m       │
│                                          │
│  [Skip for Now]  [Save Course]           │
└──────────────────────────────────────────┘
```

### 14.5 Course Override for API Courses

If GolfAPI.io data is incorrect, users can override specific fields:

```
┌──────────────────────────────────────────┐
│  Manly Golf Club - Championship          │
│  Data from GolfAPI.io                    │
│                                          │
│  ⚠️ Something wrong with this data?      │
│  [Edit Course Details]                   │
│                                          │
│  Your changes are saved locally and      │
│  won't affect the original API data.     │
└──────────────────────────────────────────┘
```

### 14.6 Data Model for Manual/Override Courses

```sql
CREATE TABLE user_courses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users NOT NULL,

  -- Source tracking
  source TEXT NOT NULL,  -- 'golfapi' | 'manual' | 'override'
  golfapi_course_id TEXT,  -- Original API ID if override

  -- Course info
  club_name TEXT NOT NULL,
  course_name TEXT,
  city TEXT,
  state TEXT,
  country TEXT DEFAULT 'AU',

  -- Course data
  holes INT NOT NULL DEFAULT 18,
  par_total INT NOT NULL,
  total_distance INT,  -- metres

  -- Tee data (JSONB for flexibility)
  tees JSONB NOT NULL,  -- [{name, gender, rating, slope, distances[]}]

  -- Hole data (JSONB)
  hole_data JSONB,  -- [{hole, par, si, distance}]

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for search
CREATE INDEX idx_user_courses_search
ON user_courses USING gin(to_tsvector('english', club_name || ' ' || COALESCE(course_name, '')));
```

---

## 15. Development Team & Sprint Plan

### 15.1 Team Structure

| Role | Allocation | Responsibilities |
|------|------------|------------------|
| **Tech Lead** | 1.0 FTE | Architecture, code review, API integrations (GA CONNECT, GolfAPI.io), CI/CD |
| **Flutter Dev 1** | 1.0 FTE | Dashboard, Tournaments, Scorecard, Course Search, Analytics |
| **Flutter Dev 2** | 1.0 FTE | Media system: Camera, Gallery, Video, Compression, Upload |
| **Backend Dev** | 1.0 FTE | Supabase schema, RLS policies, Edge Functions, Storage |
| **QA Engineer** | 0.5 FTE | Test plans, iOS + Android device testing, regression |

**Total: 4.5 FTE · 16 weeks**

### 15.2 Team Workflow

```
                    ┌─────────────────┐
                    │   Tech Lead     │
                    │  Architecture   │
                    │  Code Review    │
                    │  API Integration│
                    └────────┬────────┘
                             │
           ┌─────────────────┼─────────────────┐
           │                 │                 │
           ▼                 ▼                 ▼
    ┌─────────────┐   ┌─────────────┐   ┌─────────────┐
    │ Flutter Dev │   │ Flutter Dev │   │  Backend    │
    │     #1      │   │     #2      │   │    Dev      │
    │             │   │             │   │             │
    │ • Dashboard │   │ • Media     │   │ • Supabase  │
    │ • Tourneys  │   │ • Camera    │   │ • Schema    │
    │ • Scorecard │   │ • Gallery   │   │ • RLS       │
    │ • Analytics │   │ • Video     │   │ • Storage   │
    │ • Courses   │   │ • Compress  │   │ • Edge Fn   │
    └──────┬──────┘   └──────┬──────┘   └──────┬──────┘
           │                 │                 │
           └─────────────────┼─────────────────┘
                             ▼
                    ┌─────────────────┐
                    │   QA Engineer   │
                    │  Test Plans     │
                    │  Device Testing │
                    │  Regression     │
                    └─────────────────┘
```

### 15.3 Sprint Plan (16 Weeks)

| Sprint | Weeks | Focus | Key Deliverables |
|--------|-------|-------|------------------|
| **1** | 1-2 | Foundation | Flutter project, Supabase setup, auth, theme, navigation, CI/CD |
| **2** | 3-4 | Player & Dashboard | Player profile, phase selector, dashboard, handicap entry |
| **3** | 5-6 | Course Integration | GolfAPI.io client, course search, manual entry, caching |
| **4** | 7-8 | Tournament Core | Tournament CRUD, round entry, hole-by-hole scorecard |
| **5** | 9-10 | Media System | Photo/video capture, compression, upload, gallery |
| **6** | 11-12 | Analytics & GA CONNECT | Stats engine, charts, GA CONNECT WebView scraping |
| **7** | 13-14 | Polish | Highlights, milestones, training log, bug fixes |
| **8** | 15-16 | Release Prep | TestFlight, internal testing, final QA, docs |

### 15.4 Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| GA CONNECT site changes | Medium | High | Isolated scraping module, manual fallback always available |
| GolfAPI.io free tier limits | Medium | Medium | Aggressive caching, manual course entry fallback |
| App Store rejection (minor data) | Low | High | Privacy docs prepared early, parental consent flow |
| Video compression performance | Low | Medium | Test on older devices in Sprint 5, adjust quality |
| Scope creep | Medium | Medium | Strict sprint goals, defer nice-to-haves to Phase 2 |

---

## 16. Success Metrics

---

## 16. Success Metrics

| Metric | Personal Phase | Public Phase |
|--------|---------------|--------------|
| Data Completeness | 80%+ rounds with hole-by-hole data | Same |
| Media Capture | 5+ media items per tournament | 3+ per user per tournament |
| Handicap Accuracy | Within 0.5 of official GA HC | Same |
| Course Auto-Load Rate | 90%+ AU courses found | 85%+ globally |
| App Reliability | < 1 crash per month | < 0.1% crash rate |
| User Engagement | — | Weekly active rate > 60% |
| Public Registration | — | 100 families in first 6 months |

---

## 17. Sprint 1 Detailed Task Breakdown

### Sprint 1 Overview
**Duration:** Weeks 1-2
**Goal:** Foundation — Project setup, infrastructure, authentication, core navigation

---

### 17.1 Tech Lead Tasks

| ID | Task | Priority | Est. Hours | Dependencies |
|----|------|----------|------------|--------------|
| TL-1.1 | Create GitHub repository with branch protection rules | P0 | 2 | — |
| TL-1.2 | Set up CI/CD pipeline (GitHub Actions → build iOS/Android) | P0 | 6 | TL-1.1 |
| TL-1.3 | Create Supabase project (Sydney region: ap-southeast-2) | P0 | 1 | — |
| TL-1.4 | Configure Supabase Auth (email/password for MVP) | P0 | 2 | TL-1.3 |
| TL-1.5 | Document coding standards and PR review process | P1 | 3 | — |
| TL-1.6 | Set up Firebase project for push notifications (future) | P2 | 2 | — |
| TL-1.7 | Research GolfAPI.io: sign up, test endpoints, document limits | P1 | 4 | — |
| TL-1.8 | Research golf.com.au page structure for scraping feasibility | P1 | 4 | — |
| TL-1.9 | Sprint 1 code review and merge coordination | P0 | 4 | All |

---

### 17.2 Backend Developer Tasks

| ID | Task | Priority | Est. Hours | Dependencies |
|----|------|----------|----------|--------------|
| BE-1.1 | Design core database schema (players, tournaments, rounds, holes) | P0 | 6 | TL-1.3 |
| BE-1.2 | Create Supabase migrations for core tables | P0 | 4 | BE-1.1 |
| BE-1.3 | Implement RLS policies for all tables (user_id isolation) | P0 | 4 | BE-1.2 |
| BE-1.4 | Create storage bucket `tournament-media` with RLS | P0 | 2 | TL-1.3 |
| BE-1.5 | Create storage bucket structure (media/, thumbnails/) | P1 | 2 | BE-1.4 |
| BE-1.6 | Set up Supabase Edge Function scaffold | P2 | 3 | TL-1.3 |
| BE-1.7 | Create seed data script for development/testing | P1 | 3 | BE-1.2 |
| BE-1.8 | Document API contracts (Supabase table schemas, RPC functions) | P1 | 4 | BE-1.2 |

**Schema deliverable (BE-1.1):**

```sql
-- Core tables for Sprint 1
CREATE TABLE players (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users NOT NULL,
  name TEXT NOT NULL,
  date_of_birth DATE,
  golf_id TEXT,
  current_handicap DECIMAL(4,1),
  current_phase INT DEFAULT 1 CHECK (current_phase BETWEEN 1 AND 4),
  avatar_path TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE handicap_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  player_id UUID REFERENCES players NOT NULL,
  handicap_value DECIMAL(4,1) NOT NULL,
  effective_date DATE NOT NULL,
  source TEXT DEFAULT 'manual', -- 'manual' | 'ga_connect'
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- More tables in Sprint 3-4...
```

---

### 17.3 Flutter Developer #1 Tasks

| ID | Task | Priority | Est. Hours | Dependencies |
|----|------|----------|------------|--------------|
| FD1-1.1 | Initialize Flutter project with recommended structure | P0 | 3 | TL-1.1 |
| FD1-1.2 | Configure `supabase_flutter` package and environment | P0 | 2 | TL-1.3, FD1-1.1 |
| FD1-1.3 | Set up Riverpod for state management | P0 | 2 | FD1-1.1 |
| FD1-1.4 | Configure GoRouter with initial routes | P0 | 3 | FD1-1.1 |
| FD1-1.5 | Create app theme (colors, typography, component styles) | P0 | 4 | FD1-1.1 |
| FD1-1.6 | Build Login screen UI | P0 | 4 | FD1-1.5 |
| FD1-1.7 | Implement login logic with Supabase Auth | P0 | 3 | FD1-1.6, TL-1.4 |
| FD1-1.8 | Build Dashboard shell (bottom nav, app bar) | P1 | 4 | FD1-1.4 |
| FD1-1.9 | Create placeholder screens (Dashboard, Tournaments, Profile) | P1 | 3 | FD1-1.8 |
| FD1-1.10 | Implement auth state management (logged in/out routing) | P0 | 3 | FD1-1.7 |

**Theme deliverable (FD1-1.5):**

```dart
// lib/app/theme.dart
class AppTheme {
  // Primary: Golf Green
  static const primaryColor = Color(0xFF2E7D32);
  static const primaryLight = Color(0xFF60AD5E);
  static const primaryDark = Color(0xFF005005);

  // Secondary: Navy Blue (D1 collegiate feel)
  static const secondaryColor = Color(0xFF1A237E);

  // Accent: Gold (achievement/trophy)
  static const accentColor = Color(0xFFFFD700);

  // Neutrals
  static const backgroundColor = Color(0xFFF5F5F5);
  static const surfaceColor = Colors.white;
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
}
```

---

### 17.4 Flutter Developer #2 Tasks

| ID | Task | Priority | Est. Hours | Dependencies |
|----|------|----------|------------|--------------|
| FD2-1.1 | Set up media packages (image_picker, video_player, etc.) | P1 | 3 | FD1-1.1 |
| FD2-1.2 | Configure permission_handler for camera/gallery | P1 | 2 | FD2-1.1 |
| FD2-1.3 | Create MediaService interface (capture, compress, upload) | P1 | 4 | FD2-1.1 |
| FD2-1.4 | Test image capture and basic compression | P1 | 3 | FD2-1.3 |
| FD2-1.5 | Test video capture (verify 120s limit, 720p) | P1 | 3 | FD2-1.3 |
| FD2-1.6 | Create shared widgets library scaffold | P1 | 4 | FD1-1.5 |
| FD2-1.7 | Build reusable button components (primary, secondary, text) | P1 | 3 | FD2-1.6 |
| FD2-1.8 | Build reusable input components (text field, dropdown) | P1 | 3 | FD2-1.6 |
| FD2-1.9 | Build reusable card components | P1 | 3 | FD2-1.6 |
| FD2-1.10 | Document shared widget usage in README | P2 | 2 | FD2-1.6 |

---

### 17.5 QA Engineer Tasks

| ID | Task | Priority | Est. Hours | Dependencies |
|----|------|----------|------------|--------------|
| QA-1.1 | Set up test devices (iOS + Android, multiple screen sizes) | P0 | 4 | — |
| QA-1.2 | Create test plan template for sprints | P1 | 3 | — |
| QA-1.3 | Define acceptance criteria for Sprint 1 deliverables | P0 | 4 | All task lists |
| QA-1.4 | Test login flow on iOS | P0 | 3 | FD1-1.7 |
| QA-1.5 | Test login flow on Android | P0 | 3 | FD1-1.7 |
| QA-1.6 | Test navigation and auth state persistence | P1 | 2 | FD1-1.10 |
| QA-1.7 | File bugs in GitHub Issues with reproduction steps | P0 | Ongoing | All |
| QA-1.8 | Verify Supabase RLS policies (cannot access other user data) | P0 | 2 | BE-1.3 |

---

### 17.6 Sprint 1 Definition of Done

| Deliverable | Acceptance Criteria |
|-------------|---------------------|
| **GitHub Repo** | Main branch protected, PR required, CI passes |
| **CI/CD** | Push to main triggers iOS + Android build |
| **Supabase** | Project created, auth working, core schema deployed |
| **Flutter App** | Launches on iOS + Android simulators |
| **Login** | User can sign up, log in, log out |
| **Navigation** | Bottom nav works, routes protected by auth |
| **Theme** | Consistent colors, typography across app |
| **Media Setup** | Camera permission requested, test capture works |

---

### 17.7 Sprint 1 Gantt Chart

```
Week 1                              Week 2
Day: 1   2   3   4   5   6   7   8   9   10
     ├───┴───┴───┴───┴───┤───┴───┴───┴───┤

TL:  [Repo + CI/CD setup ][GolfAPI research][Code review  ]
     [Supabase setup     ][GA scrape rsrch ]

BE:  [Schema design      ][Migrations + RLS][Seed data    ]
     [                   ][Storage buckets ][Documentation]

FD1: [Flutter init       ][Theme + Router  ][Login screen ]
     [Supabase + Riverpod][               ][Dashboard nav]

FD2: [Media pkg setup    ][Permission hdlr ][Shared widgets]
     [MediaService iface ][Capture tests   ][Components   ]

QA:  [Device setup       ][Test plan       ][Login testing]
     [                   ][Criteria        ][Bug filing   ]
```

---

### 17.8 Sprint 1 Risks

| Risk | Mitigation |
|------|------------|
| Supabase Auth issues | Fallback to Firebase Auth if critical blockers |
| Flutter/Dart version conflicts | Pin versions in pubspec.yaml, document in README |
| iOS certificate/provisioning issues | Tech Lead handles Apple Developer setup Day 1 |
| Team onboarding delays | Day 1 kickoff meeting, pair programming first 2 days |

---

*This document should be reviewed quarterly. Next review: May 2026.*
