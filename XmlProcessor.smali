# classes4.dex

.class public final Lcom/twntool/editor/core/XmlProcessor;
.super Ljava/lang/Object;
.source "XmlProcessor.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/twntool/editor/core/XmlProcessor$BarnItem;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nXmlProcessor.kt\nKotlin\n*S Kotlin\n*F\n+ 1 XmlProcessor.kt\ncom/twntool/editor/core/XmlProcessor\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 4 Maps.kt\nkotlin/collections/MapsKt__MapsKt\n+ 5 _Sequences.kt\nkotlin/sequences/SequencesKt___SequencesKt\n*L\n1#1,1521:1\n1#2:1522\n1#2:1537\n827#3:1523\n855#3,2:1524\n1053#3:1526\n1611#3,9:1527\n1863#3:1536\n1864#3:1538\n1620#3:1539\n1557#3:1540\n1628#3,3:1541\n774#3:1544\n865#3,2:1545\n774#3:1547\n865#3,2:1548\n774#3:1550\n865#3,2:1551\n1557#3:1560\n1628#3,3:1561\n1053#3:1564\n774#3:1565\n865#3,2:1566\n1863#3,2:1570\n503#4,7:1553\n1317#5,2:1568\n*S KotlinDebug\n*F\n+ 1 XmlProcessor.kt\ncom/twntool/editor/core/XmlProcessor\n*L\n232#1:1537\n109#1:1523\n109#1:1524,2\n110#1:1526\n232#1:1527,9\n232#1:1536\n232#1:1538\n232#1:1539\n252#1:1540\n252#1:1541,3\n252#1:1544\n252#1:1545,2\n267#1:1547\n267#1:1548,2\n289#1:1550\n289#1:1551,2\n717#1:1560\n717#1:1561,3\n730#1:1564\n829#1:1565\n829#1:1566,2\n1408#1:1570,2\n318#1:1553,7\n1393#1:1568,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000^\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0003\n\u0002\u0010\u000e\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\b\u0005\n\u0002\u0010\b\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0006\n\u0002\u0010$\n\u0002\u0010 \n\u0002\b\u000e\n\u0002\u0010\"\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\r\n\u0002\u0010\t\n\u0002\b\b\n\u0002\u0010\u0011\n\u0002\b\u000b\bÇ\u0002\u0018\u00002\u00020\u0001:\u0001OB\t\b\u0002¢\u0006\u0004\b\u0002\u0010\u0003J\u0018\u0010\u0006\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0007\u001a\u00020\u00052\u0006\u0010\b\u001a\u00020\u0005J*\u0010\t\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u00052\u0006\u0010\b\u001a\u00020\u00052\u0006\u0010\f\u001a\u00020\u0005J\u001e\u0010\r\u001a\u00020\u00052\u0006\u0010\u0007\u001a\u00020\u00052\u0006\u0010\b\u001a\u00020\u00052\u0006\u0010\u000e\u001a\u00020\u0005J$\u0010\u000f\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u00052\b\b\u0002\u0010\u0010\u001a\u00020\u0011J \u0010\u0012\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u0011\u0012\u0004\u0012\u00020\u00110\u00132\u0006\u0010\u0007\u001a\u00020\u0005J\u001a\u0010\u0014\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00110\n2\u0006\u0010\u0007\u001a\u00020\u0005J\u001a\u0010\u0015\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u0005J\u0010\u0010\u0016\u001a\u00020\u00052\u0006\u0010\u0007\u001a\u00020\u0005H\u0002J\u001a\u0010\u0017\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u0005J8\u0010\u0018\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\n2\u0006\u0010\u0007\u001a\u00020\u00052\u001c\b\u0002\u0010\u0019\u001a\u0016\u0012\u0004\u0012\u00020\u0005\u0012\n\u0012\b\u0012\u0004\u0012\u00020\u00110\u001b\u0018\u00010\u001aJ.\u0010\u001c\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\n2\u0006\u0010\u0007\u001a\u00020\u00052\u0012\u0010\u001d\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00110\u001aJ\u001a\u0010\u001e\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u0005J\u000e\u0010\u001f\u001a\u00020\u00112\u0006\u0010 \u001a\u00020\u0011J\u000e\u0010!\u001a\u00020\u00112\u0006\u0010\"\u001a\u00020\u0011J\u000e\u0010#\u001a\u00020\u00112\u0006\u0010\u0007\u001a\u00020\u0005J\u000e\u0010$\u001a\u00020\u00112\u0006\u0010\u0007\u001a\u00020\u0005J\u000e\u0010%\u001a\u00020\u000b2\u0006\u0010\u0007\u001a\u00020\u0005J*\u0010&\u001a\u00020\u00052\u0006\u0010\u0007\u001a\u00020\u00052\u0006\u0010\b\u001a\u00020\u00052\u0006\u0010\u000e\u001a\u00020\u00052\b\b\u0002\u0010\'\u001a\u00020\u0005H\u0002J\"\u0010(\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\n2\u0006\u0010\u0007\u001a\u00020\u00052\u0006\u0010 \u001a\u00020\u0011J\u0014\u0010-\u001a\b\u0012\u0004\u0012\u00020.0\u001b2\u0006\u0010\u0007\u001a\u00020\u0005J4\u0010/\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u0011\u0012\u0004\u0012\u00020\u00110\u00132\u0006\u0010\u0007\u001a\u00020\u00052\u0012\u00100\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00110\u001aJ$\u00101\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00110\n2\u0006\u0010\u0007\u001a\u00020\u00052\b\b\u0002\u00102\u001a\u00020\u0005J\u001a\u00106\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00110\n2\u0006\u0010\u0007\u001a\u00020\u0005J\u001a\u00107\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00110\n2\u0006\u0010\u0007\u001a\u00020\u0005J,\u00108\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u00052\u0010\b\u0002\u00109\u001a\n\u0012\u0004\u0012\u00020\u0005\u0018\u00010*J \u0010=\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u0011\u0012\u0004\u0012\u00020\u00110\u00132\u0006\u0010\u0007\u001a\u00020\u0005J(\u0010>\u001a\u00020\u00052\u0006\u0010\u0007\u001a\u00020\u00052\u0006\u0010\b\u001a\u00020\u00052\u0006\u0010\u000e\u001a\u00020\u00052\u0006\u0010?\u001a\u00020\u0005H\u0002J\u001a\u0010G\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020<0\u001a2\u0006\u0010\u0007\u001a\u00020\u0005J\"\u0010H\u001a\u00020\u00052\u0006\u0010\u0007\u001a\u00020\u00052\u0012\u0010I\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020<0\u001aJ\u001a\u0010J\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00110\n2\u0006\u0010\u0007\u001a\u00020\u0005J\u001a\u0010K\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u0005J$\u0010L\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000b0\n2\u0006\u0010\u0007\u001a\u00020\u00052\b\b\u0002\u0010M\u001a\u00020\u0011R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082D¢\u0006\u0002\n\u0000R\u0014\u0010)\u001a\b\u0012\u0004\u0012\u00020\u00050*X\u0082\u0004¢\u0006\u0002\n\u0000R\u000e\u0010+\u001a\u00020,X\u0082\u0004¢\u0006\u0002\n\u0000R\u001a\u00103\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\u001aX\u0082\u0004¢\u0006\u0002\n\u0000R\u001a\u00104\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\u001aX\u0082\u0004¢\u0006\u0002\n\u0000R\u001a\u00105\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\u001aX\u0082\u0004¢\u0006\u0002\n\u0000R\u0014\u0010:\u001a\b\u0012\u0004\u0012\u00020\u00050\u001bX\u0082\u0004¢\u0006\u0002\n\u0000R,\u0010;\u001a \u0012\u0004\u0012\u00020\u0005\u0012\u0016\u0012\u0014\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020<0\n0\u001b0\u001aX\u0082\u0004¢\u0006\u0002\n\u0000R\u0017\u0010@\u001a\b\u0012\u0004\u0012\u00020\u00050\u001b¢\u0006\b\n\u0000\u001a\u0004\bA\u0010BR\u000e\u0010C\u001a\u00020<X\u0082T¢\u0006\u0002\n\u0000R\u001a\u0010D\u001a\u000e\u0012\n\u0012\b\u0012\u0004\u0012\u00020\u00050E0\u001bX\u0082\u0004¢\u0006\u0002\n\u0000R\u001a\u0010F\u001a\u000e\u0012\n\u0012\b\u0012\u0004\u0012\u00020\u00050E0\u001bX\u0082\u0004¢\u0006\u0002\n\u0000R\u000e\u0010N\u001a\u00020\u0005X\u0082\u0004¢\u0006\u0002\n\u0000¨\u0006P"
    }
    d2 = {
        "Lcom/twntool/editor/core/XmlProcessor;",
        "",
        "<init>",
        "()V",
        "NL",
        "",
        "findValue",
        "xml",
        "name",
        "replaceValue",
        "Lkotlin/Pair;",
        "",
        "newValue",
        "insertVar",
        "value",
        "processRegata",
        "total",
        "",
        "unlockAvatars",
        "Lkotlin/Triple;",
        "unlockBuildingSkins",
        "unlockVehicleSkins",
        "applyChatEmoji",
        "unlockStickers",
        "unlockProfile",
        "selection",
        "",
        "",
        "addItems",
        "items",
        "activateSeasonPass",
        "barnCapacityFromUpgrades",
        "upgrades",
        "barnUpgradesFromCapacity",
        "capacity",
        "getBarnUpgrades",
        "getBarnCapacity",
        "isBarnIntegrityOK",
        "insertVarTyped",
        "type",
        "setBarnCapacity",
        "BARN_COUNTER_BLACKLIST",
        "",
        "BARN_COUNTER_RX",
        "Lkotlin/text/Regex;",
        "getBarnItems",
        "Lcom/twntool/editor/core/XmlProcessor$BarnItem;",
        "setBarnItems",
        "updates",
        "applyAcademiaIndustria",
        "mode",
        "ACADEMIA_FACTORIES",
        "ACADEMIA_TRAINS",
        "ACADEMIA_ISLANDS",
        "applyTodasCartas",
        "applyMinhasCartas",
        "applyTodasVantagens",
        "selecionados",
        "ACHIEVEMENT_REWARDS",
        "ACHIEVEMENT_COUNTERS",
        "",
        "unlockAchievements",
        "upsertVarTyped",
        "tipo",
        "M3_VARS",
        "getM3_VARS",
        "()Ljava/util/List;",
        "TOWNSHIP_XOR_KEY",
        "GEM_BULLION_FIELDS",
        "",
        "PLAIN_ONLY_FIELDS",
        "getM3Quantities",
        "setM3Quantities",
        "data",
        "unlockTerrenos",
        "processRegataApk",
        "processMarketSlots",
        "count",
        "BOOSTER2X_TEMPLATE",
        "BarnItem",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final $stable:I

.field private static final ACADEMIA_FACTORIES:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final ACADEMIA_ISLANDS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final ACADEMIA_TRAINS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final ACHIEVEMENT_COUNTERS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;>;>;"
        }
    .end annotation
.end field

.field private static final ACHIEVEMENT_REWARDS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final BARN_COUNTER_BLACKLIST:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final BARN_COUNTER_RX:Lkotlin/text/Regex;

.field private static final BOOSTER2X_TEMPLATE:Ljava/lang/String;

.field private static final GEM_BULLION_FIELDS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "[",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static final INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

.field private static final M3_VARS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final NL:Ljava/lang/String;

.field private static final PLAIN_ONLY_FIELDS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "[",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final TOWNSHIP_XOR_KEY:J = 0x1e5d6a06L


# direct methods
.method public static synthetic $r8$lambda$2vlWTzPUx7YZg-UJBFglNyT6l10(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 2

    invoke-static {p0, p1}, Lcom/twntool/editor/core/XmlProcessor;->unlockProfile$lambda$22(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$5GdgBDbPbiPNHE6lH_-g4GFswUE(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasVantagens$lambda$39(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$8cZRKfaMw8gMp6BlZ6VSCs8EXzM(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->unlockAvatars$lambda$8(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$E6KPOcdUNPgOXNbKTtixywBOStg(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasCartas$lambda$32(Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$Gmbj6olcuUxhMEZKjH7_KI5jlzU(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->unlockAvatars$lambda$5(Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$Hb5mzexG8UmFlG2tAoB249H6NG4(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->unlockBuildingSkins$lambda$9(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$NaNwZapHZEDKdvT_nGJoBpwlaT4(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->unlockTerrenos$lambda$45(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$RJvLc666DK06_a72tHw38vFNKWI(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->unlockAchievements$lambda$42(Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$ZfFJrsHU4hR24bei1Z1KMHEAZC8(Ljava/util/Map;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 4

    invoke-static {p0, p1, p2, p3}, Lcom/twntool/editor/core/XmlProcessor;->applyAcademiaIndustria$replaceTags$lambda$30(Ljava/util/Map;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$aYGIT9ju80iMzfF0aKYejPJPlJI(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->applyMinhasCartas$sub$lambda$37(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$buNoq_lDf2SNUsiQ6nxa8NqKY7k(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasCartas$lambda$36(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$bwhktYR8WFqbpfMPAAED3riT40E(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 3

    invoke-static {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue$lambda$2(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$cWm35ijU7lWrYYgVDf-TkZVFKbs(Ljava/lang/Long;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 2

    invoke-static {p0, p1}, Lcom/twntool/editor/core/XmlProcessor;->setM3Quantities$lambda$44(Ljava/lang/Long;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$chGetGveDZUwwvObn3fccljtsII(Ljava/lang/String;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 3

    invoke-static {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->setM3Quantities$lambda$43(Ljava/lang/String;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$dK-FAIzGWNIgTQpkAzjON6WAUk8(Ljava/util/Map$Entry;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->addItems$lambda$27(Ljava/util/Map$Entry;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$dmPnKv7BL2TCdlHiE7DfbY37op4(Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 2

    invoke-static {p0, p1}, Lcom/twntool/editor/core/XmlProcessor;->unlockAvatars$lambda$4(Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$kl4sg_mi7Cqt-cHWiF3WfUlrBCw(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 3

    invoke-static {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue$lambda$3(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$ljocRnMP5Gtyz9NKRE8oWbRkIX8(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 2

    invoke-static {p0, p1}, Lcom/twntool/editor/core/XmlProcessor;->unlockProfile$lambda$25(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$phRBAR8FIYNMAt35Kkug_80rT0A(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasCartas$lambda$31(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$sa5v4LC73lmEaNbs4NeqTvtQ7G0(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 2

    invoke-static {p0, p1}, Lcom/twntool/editor/core/XmlProcessor;->unlockProfile$lambda$24(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$xhsO267g1e-q2wFxckBm-ke5Nls(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasVantagens$lambda$40(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .registers 21

    new-instance v0, Lcom/twntool/editor/core/XmlProcessor;

    invoke-direct {v0}, Lcom/twntool/editor/core/XmlProcessor;-><init>()V

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    .line 20
    const-string v0, "\n"

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    .line 456
    nop

    .line 457
    const/16 v0, 0xd

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "questcomplete"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "localmaporder"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "maporder"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    const-string v2, "action_sessionsforsubs"

    const/4 v6, 0x3

    aput-object v2, v1, v6

    .line 458
    const-string v2, "storeopens"

    const/4 v7, 0x4

    aput-object v2, v1, v7

    .line 457
    nop

    .line 458
    const-string v2, "queststreak"

    const/4 v8, 0x5

    aput-object v2, v1, v8

    .line 457
    nop

    .line 458
    const-string v2, "rateusshow"

    const/4 v9, 0x6

    aput-object v2, v1, v9

    .line 457
    nop

    .line 458
    const-string v2, "session"

    const/4 v10, 0x7

    aput-object v2, v1, v10

    .line 457
    nop

    .line 458
    const-string v2, "launch"

    const/16 v11, 0x8

    aput-object v2, v1, v11

    .line 457
    nop

    .line 459
    const-string v2, "tutorialcloudcountmessage_build_milkfactory_tutorial"

    const/16 v12, 0x9

    aput-object v2, v1, v12

    .line 457
    nop

    .line 460
    const-string v2, "tutorialcloudcountmessage_full_field_tutorial"

    const/16 v13, 0xa

    aput-object v2, v1, v13

    .line 457
    nop

    .line 461
    const-string v2, "tutorialcloudcountmessage_houses_tutorial"

    const/16 v14, 0xb

    aput-object v2, v1, v14

    .line 457
    nop

    .line 462
    const-string v2, "tutorialcloudcountmessage_hungry_cows_tutorial"

    const/16 v15, 0xc

    aput-object v2, v1, v15

    .line 457
    nop

    .line 456
    invoke-static {v1}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v1

    sput-object v1, Lcom/twntool/editor/core/XmlProcessor;->BARN_COUNTER_BLACKLIST:Ljava/util/Set;

    .line 465
    new-instance v1, Lkotlin/text/Regex;

    .line 466
    nop

    .line 467
    sget-object v2, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    .line 465
    const-string v0, "<Var\\s+name=\"([A-Za-z0-9_]+)Counter\"\\s+v=\"(-?\\d+)\"\\s+t=\"i\"\\s*/>"

    invoke-direct {v1, v0, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    sput-object v1, Lcom/twntool/editor/core/XmlProcessor;->BARN_COUNTER_RX:Lkotlin/text/Regex;

    .line 614
    nop

    .line 615
    const/16 v0, 0x2a

    new-array v0, v0, [Lkotlin/Pair;

    const-string v1, "bagfactory"

    const-string v2, "level=\"39\" slx=\"32161994\" xpBonus=\"100\" moneyBonus=\"100\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v3

    .line 616
    const-string v1, "bakery"

    const-string v2, "level=\"53\" slx=\"32162008\" xpBonus=\"100\" moneyBonus=\"100\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v4

    .line 615
    nop

    .line 617
    const-string v1, "bouquetfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v5

    .line 615
    nop

    .line 618
    const-string v1, "cakefactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v6

    .line 615
    nop

    .line 619
    const-string v1, "candyfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v7

    .line 615
    nop

    .line 620
    const-string v1, "chipsfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v8

    .line 615
    nop

    .line 621
    const-string v1, "chocolatefactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v9

    .line 615
    nop

    .line 622
    const-string v1, "clothingfactory"

    const-string v9, "level=\"38\" slx=\"32161995\" xpBonus=\"100\" moneyBonus=\"100\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v10

    .line 615
    nop

    .line 623
    const-string v1, "coffeefactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v11

    .line 615
    nop

    .line 624
    const-string v1, "cottonfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v12

    .line 615
    nop

    .line 625
    const-string v1, "dollfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v13

    .line 615
    nop

    .line 626
    const-string v1, "drinksfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v14

    .line 615
    nop

    .line 627
    const-string v1, "factory_music_instruments"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v15

    .line 615
    nop

    .line 628
    const-string v1, "fastfoodfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v16, 0xd

    aput-object v1, v0, v16

    .line 615
    nop

    .line 629
    const-string v1, "featherfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v17, 0xe

    aput-object v1, v0, v17

    .line 615
    nop

    .line 630
    const-string v1, "frenchrestaurant"

    const-string v15, "level=\"43\" slx=\"32161990\" xpBonus=\"100\" moneyBonus=\"100\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v15}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0xf

    aput-object v1, v0, v15

    .line 615
    nop

    .line 631
    const-string v1, "furniturefactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v18, 0x10

    aput-object v1, v0, v18

    .line 615
    nop

    .line 632
    const-string v1, "gardeningfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v19, 0x11

    aput-object v1, v0, v19

    .line 615
    nop

    .line 633
    const-string v1, "holidayfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v20, 0x12

    aput-object v1, v0, v20

    .line 615
    nop

    .line 634
    const-string v1, "hotdogfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v20, 0x13

    aput-object v1, v0, v20

    .line 615
    nop

    .line 635
    const-string v1, "housewaresfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v20, 0x14

    aput-object v1, v0, v20

    .line 615
    nop

    .line 636
    const-string v1, "icecreamfactory"

    const-string v15, "level=\"52\" slx=\"32162009\" xpBonus=\"100\" moneyBonus=\"100\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v15}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x15

    aput-object v1, v0, v15

    .line 615
    nop

    .line 637
    const-string v1, "italyfoodfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x16

    aput-object v1, v0, v15

    .line 615
    nop

    .line 638
    const-string v1, "jamfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x17

    aput-object v1, v0, v15

    .line 615
    nop

    .line 639
    const-string v1, "jewelryfactory"

    const-string v15, "level=\"23\" slx=\"32162042\" xpBonus=\"100\" timeBonus=\"100\""

    invoke-static {v1, v15}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x18

    aput-object v1, v0, v15

    .line 615
    nop

    .line 640
    const-string v1, "kitchenwarefactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x19

    aput-object v1, v0, v15

    .line 615
    nop

    .line 641
    const-string v1, "mexfoodfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x1a

    aput-object v1, v0, v15

    .line 615
    nop

    .line 642
    const-string v1, "milkfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x1b

    aput-object v1, v0, v15

    .line 615
    nop

    .line 643
    const-string v1, "mill"

    const-string v15, "level=\"13\" slx=\"32162016\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v15}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x1c

    aput-object v1, v0, v15

    .line 615
    nop

    .line 644
    const-string v1, "paperfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x1d

    aput-object v1, v0, v15

    .line 615
    nop

    .line 645
    const-string v1, "petfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x1e

    aput-object v1, v0, v15

    .line 615
    nop

    .line 646
    const-string v1, "roasterfactory"

    const-string v15, "level=\"43\" slx=\"32161990\" xpBonus=\"100\" moneyBonus=\"100\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v15}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x1f

    aput-object v1, v0, v15

    .line 615
    nop

    .line 647
    const-string v1, "scentfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x20

    aput-object v1, v0, v15

    .line 615
    nop

    .line 648
    const-string v1, "semifinishedfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x21

    aput-object v1, v0, v15

    .line 615
    nop

    .line 649
    const-string v1, "shoefactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x22

    aput-object v1, v0, v15

    .line 615
    nop

    .line 650
    const-string v1, "spongefactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x23

    aput-object v1, v0, v15

    .line 615
    nop

    .line 651
    const-string v1, "stationeryfactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x24

    aput-object v1, v0, v15

    .line 615
    nop

    .line 652
    const-string v1, "sugarfactory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x25

    aput-object v1, v0, v15

    .line 615
    nop

    .line 653
    const-string v1, "sushifactory"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0x26

    aput-object v1, v0, v15

    .line 615
    nop

    .line 654
    const-string v1, "tea_factory"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x27

    aput-object v1, v0, v2

    .line 615
    nop

    .line 655
    const-string v1, "vegancafe"

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x28

    aput-object v1, v0, v2

    .line 615
    nop

    .line 656
    const-string v1, "wheelfactory"

    const-string v2, "level=\"52\" slx=\"32162009\" xpBonus=\"100\" moneyBonus=\"100\" timeBonus=\"100\" shelfBonus=\"2\""

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x29

    aput-object v1, v0, v2

    .line 615
    nop

    .line 614
    invoke-static {v0}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->ACADEMIA_FACTORIES:Ljava/util/Map;

    .line 658
    nop

    .line 659
    new-array v0, v6, [Lkotlin/Pair;

    const-string v1, "1"

    const-string v2, "level=\"31\" slx=\"32162034\" xpBonus=\"100\" timeBonus=\"100\""

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v3

    .line 660
    const-string v1, "2"

    const-string v2, "level=\"31\" slx=\"32162034\" xpBonus=\"100\" timeBonus=\"100\""

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v4

    .line 659
    nop

    .line 661
    const-string v1, "3"

    const-string v2, "level=\"31\" slx=\"32162034\" xpBonus=\"100\" timeBonus=\"100\""

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v5

    .line 659
    nop

    .line 658
    invoke-static {v0}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->ACADEMIA_TRAINS:Ljava/util/Map;

    .line 663
    nop

    .line 664
    new-array v0, v8, [Lkotlin/Pair;

    const-string v1, "i1"

    const-string v2, "level=\"31\" slx=\"32162034\" timeBonus=\"99\" probability2=\"10\" probability3=\"10\""

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v3

    .line 665
    const-string v1, "i2"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v4

    .line 664
    nop

    .line 666
    const-string v1, "i3"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v5

    .line 664
    nop

    .line 667
    const-string v1, "i4"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v6

    .line 664
    nop

    .line 668
    const-string v1, "i5"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v7

    .line 664
    nop

    .line 663
    invoke-static {v0}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->ACADEMIA_ISLANDS:Ljava/util/Map;

    .line 892
    nop

    .line 893
    const/16 v0, 0x26

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "marketBoom"

    aput-object v1, v0, v3

    const-string v1, "miner"

    aput-object v1, v0, v4

    const-string v1, "earthCenter"

    aput-object v1, v0, v5

    const-string v1, "strategyReserv"

    aput-object v1, v0, v6

    const-string v1, "factoryUpgrader"

    aput-object v1, v0, v7

    .line 894
    const-string v1, "collector"

    aput-object v1, v0, v8

    .line 893
    nop

    .line 894
    const-string v1, "teamwork"

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 893
    nop

    .line 894
    const-string v1, "casinoGame"

    aput-object v1, v0, v10

    .line 893
    nop

    .line 894
    const-string v1, "sendShips"

    aput-object v1, v0, v11

    .line 893
    nop

    .line 894
    const-string v1, "islandGoods"

    aput-object v1, v0, v12

    .line 893
    nop

    .line 895
    const-string v1, "collectBacon"

    aput-object v1, v0, v13

    .line 893
    nop

    .line 895
    const-string v1, "collectHoney"

    aput-object v1, v0, v14

    .line 893
    nop

    .line 895
    const-string v1, "collectorIslands"

    const/16 v2, 0xc

    aput-object v1, v0, v2

    .line 893
    nop

    .line 895
    const-string v1, "progressWave"

    const/16 v2, 0xd

    aput-object v1, v0, v2

    .line 893
    nop

    .line 896
    const-string v1, "downFeather"

    aput-object v1, v0, v17

    .line 893
    nop

    .line 896
    const-string v1, "metropolis"

    const/16 v2, 0xf

    aput-object v1, v0, v2

    .line 893
    nop

    .line 896
    const-string v1, "community_developer"

    aput-object v1, v0, v18

    .line 893
    nop

    .line 896
    const-string v1, "entrepreneur"

    aput-object v1, v0, v19

    .line 893
    nop

    .line 897
    const-string v1, "lead_Architect"

    const/16 v2, 0x12

    aput-object v1, v0, v2

    .line 893
    nop

    .line 897
    const-string v1, "population_boom"

    const/16 v2, 0x13

    aput-object v1, v0, v2

    .line 893
    nop

    .line 897
    const-string v1, "construction_manager"

    const/16 v2, 0x14

    aput-object v1, v0, v2

    .line 893
    nop

    .line 898
    const-string v1, "endless_fields"

    const/16 v2, 0x15

    aput-object v1, v0, v2

    .line 893
    nop

    .line 898
    const-string v1, "magnate"

    const/16 v2, 0x16

    aput-object v1, v0, v2

    .line 893
    nop

    .line 898
    const-string v1, "wacky_farmer"

    const/16 v2, 0x17

    aput-object v1, v0, v2

    .line 893
    nop

    .line 898
    const-string v1, "urbanist_club"

    const/16 v2, 0x18

    aput-object v1, v0, v2

    .line 893
    nop

    .line 899
    const-string v1, "honorary_freeman"

    const/16 v2, 0x19

    aput-object v1, v0, v2

    .line 893
    nop

    .line 899
    const-string v1, "senior_train_driver"

    const/16 v2, 0x1a

    aput-object v1, v0, v2

    .line 893
    nop

    .line 899
    const-string v1, "road_champ"

    const/16 v2, 0x1b

    aput-object v1, v0, v2

    .line 893
    nop

    .line 900
    const-string v1, "production_genius"

    const/16 v2, 0x1c

    aput-object v1, v0, v2

    .line 893
    nop

    .line 900
    const-string v1, "customer_service_pro"

    const/16 v2, 0x1d

    aput-object v1, v0, v2

    .line 893
    nop

    .line 900
    const-string v1, "model_chicken_coop"

    const/16 v2, 0x1e

    aput-object v1, v0, v2

    .line 893
    nop

    .line 901
    const-string v1, "milky_way"

    const/16 v2, 0x1f

    aput-object v1, v0, v2

    .line 893
    nop

    .line 901
    const-string v1, "mushroom"

    const/16 v2, 0x20

    aput-object v1, v0, v2

    .line 893
    nop

    .line 901
    const-string v1, "wool_art"

    const/16 v2, 0x21

    aput-object v1, v0, v2

    .line 893
    nop

    .line 901
    const-string v1, "seaweed"

    const/16 v2, 0x22

    aput-object v1, v0, v2

    .line 893
    nop

    .line 901
    const-string v1, "donate"

    const/16 v2, 0x23

    aput-object v1, v0, v2

    .line 893
    nop

    .line 902
    const-string v1, "regataChampion"

    const/16 v2, 0x24

    aput-object v1, v0, v2

    .line 893
    nop

    .line 902
    const-string v1, "match3_achievement"

    const/16 v2, 0x25

    aput-object v1, v0, v2

    .line 893
    nop

    .line 892
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->ACHIEVEMENT_REWARDS:Ljava/util/List;

    .line 904
    nop

    .line 905
    const/16 v0, 0x26

    new-array v0, v0, [Lkotlin/Pair;

    const-wide/16 v1, 0x3e80

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_MarketBoom"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "marketBoom"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v3

    .line 906
    const-wide/16 v1, 0x36b0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_Miner"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "miner"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v4

    .line 905
    nop

    .line 907
    const-wide/16 v1, 0x4268

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_EarthCenter"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "earthCenter"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v5

    .line 905
    nop

    .line 908
    const-wide/16 v1, 0xdac

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_StrategyReserv"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "strategyReserv"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v6

    .line 905
    nop

    .line 909
    const-wide/16 v1, 0x2a

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_FactoryUpgrader"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "factoryUpgrader"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v7

    .line 905
    nop

    .line 910
    const-wide/16 v1, 0x19

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_Collector"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "collector"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v8

    .line 905
    nop

    .line 911
    const-wide/16 v1, 0x4e20

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_Teamwork"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "teamwork"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 905
    nop

    .line 912
    const-wide/16 v1, 0xfa0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CasinoGame"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "casinoGame"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v10

    .line 905
    nop

    .line 913
    const-wide/16 v1, 0x4650

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_sendShips"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "sendShips"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v11

    .line 905
    nop

    .line 914
    const-wide/32 v1, 0x1adb0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_islandGoods"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "islandGoods"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v12

    .line 905
    nop

    .line 915
    const-wide/16 v1, 0x3c8c

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CollectBacon"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "collectBacon"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v13

    .line 905
    nop

    .line 916
    const-wide/16 v1, 0x38a4

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CollectHoney"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "collectHoney"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v14

    .line 905
    nop

    .line 917
    const-wide/16 v1, 0x1e

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CollectorIslands"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "collectorIslands"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0xc

    aput-object v1, v0, v2

    .line 905
    nop

    .line 918
    const-wide/16 v1, 0xa5

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_progressWave"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "progressWave"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0xd

    aput-object v1, v0, v2

    .line 905
    nop

    .line 919
    const-wide/16 v1, 0x36b0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_DownFeather"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "downFeather"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v17

    .line 905
    nop

    .line 920
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x7148

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_IncreasedPopulation"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v3

    .line 921
    const-wide/16 v14, 0x2ee0

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_IncreasedPopulation_Current"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v4

    .line 920
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "metropolis"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0xf

    aput-object v1, v0, v2

    .line 905
    nop

    .line 922
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x46

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_CommunityDeveloper"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v3

    .line 923
    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_CommunityDeveloper_Current"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v4

    .line 922
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "community_developer"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v18

    .line 905
    nop

    .line 924
    const-wide/16 v1, 0x1bbc

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_FillOrders"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "entrepreneur"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v0, v19

    .line 905
    nop

    .line 925
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x82

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_BuiltHouses"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v3

    .line 926
    const-wide/16 v14, 0x1a

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_BuiltHouses_Current"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v4

    .line 925
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "lead_Architect"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x12

    aput-object v1, v0, v2

    .line 905
    nop

    .line 927
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x7148

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_IncreasedPopulation"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v3

    .line 928
    const-wide/16 v14, 0x2ee0

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_IncreasedPopulation_Current"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v4

    .line 927
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "population_boom"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x13

    aput-object v1, v0, v2

    .line 905
    nop

    .line 929
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x2d

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_BuiltFactories"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v3

    .line 930
    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_BuiltFactories_Current"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v4

    .line 929
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "construction_manager"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x14

    aput-object v1, v0, v2

    .line 905
    nop

    .line 931
    const-wide/32 v1, 0xb4aa0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_PlowedFields"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "endless_fields"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x15

    aput-object v1, v0, v2

    .line 905
    nop

    .line 932
    const-wide/32 v1, 0x29b92700

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_EarneCoins"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "magnate"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x16

    aput-object v1, v0, v2

    .line 905
    nop

    .line 933
    const-wide/16 v1, 0x84

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_GetFields"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "wacky_farmer"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x17

    aput-object v1, v0, v2

    .line 905
    nop

    .line 934
    const-wide/16 v1, 0x186

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_ExpandField"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "urbanist_club"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x18

    aput-object v1, v0, v2

    .line 905
    nop

    .line 935
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0xeb

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_EnteredGame"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v3

    .line 936
    const-wide/16 v14, 0xf

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_EnteredGame_Current"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v4

    .line 935
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "honorary_freeman"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x19

    aput-object v1, v0, v2

    .line 905
    nop

    .line 937
    const-wide/16 v1, 0x8fc

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_SentTrain"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "senior_train_driver"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x1a

    aput-object v1, v0, v2

    .line 905
    nop

    .line 938
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x1b8

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_BuiltRoad"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v3

    .line 939
    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v9, "Achievement_BuiltRoad_Current"

    invoke-static {v9, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    aput-object v2, v1, v4

    .line 938
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "road_champ"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x1b

    aput-object v1, v0, v2

    .line 905
    nop

    .line 940
    const-wide/32 v1, 0x61a80

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_ProducedProducts"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "production_genius"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x1c

    aput-object v1, v0, v2

    .line 905
    nop

    .line 941
    const-wide/16 v1, 0x1bbc

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_FillOrders"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "customer_service_pro"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x1d

    aput-object v1, v0, v2

    .line 905
    nop

    .line 942
    const-wide/32 v1, 0xea60

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CollectEggs"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "model_chicken_coop"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x1e

    aput-object v1, v0, v2

    .line 905
    nop

    .line 943
    const-wide/32 v1, 0x1a5e0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CollectMilk"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "milky_way"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x1f

    aput-object v1, v0, v2

    .line 905
    nop

    .line 944
    const-wide/16 v1, 0x3908

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CollectMushroom"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "mushroom"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x20

    aput-object v1, v0, v2

    .line 905
    nop

    .line 945
    const-wide/16 v1, 0x52d0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CollectWool"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "wool_art"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x21

    aput-object v1, v0, v2

    .line 905
    nop

    .line 946
    const-wide/16 v1, 0x4e20

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_seaweed"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "seaweed"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x22

    aput-object v1, v0, v2

    .line 905
    nop

    .line 947
    const-wide/16 v1, 0x30d4

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_donate"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "donate"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x23

    aput-object v1, v0, v2

    .line 905
    nop

    .line 948
    const-wide/16 v1, 0x1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_regataChampion"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "regataChampion"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x24

    aput-object v1, v0, v2

    .line 905
    nop

    .line 949
    const-wide/32 v1, 0xdac0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Achievement_CompleteMatch3Levels"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v2, "match3_achievement"

    invoke-static {v2, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v2, 0x25

    aput-object v1, v0, v2

    .line 905
    nop

    .line 904
    invoke-static {v0}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->ACHIEVEMENT_COUNTERS:Ljava/util/Map;

    .line 1008
    nop

    .line 1009
    new-array v0, v10, [Ljava/lang/String;

    const-string v1, "m3Line"

    aput-object v1, v0, v3

    const-string v1, "m3Bomb"

    aput-object v1, v0, v4

    const-string v1, "m3RainbowBall"

    aput-object v1, v0, v5

    const-string v1, "m3Mallet"

    aput-object v1, v0, v6

    .line 1010
    const-string v1, "m3HorizontalLine"

    aput-object v1, v0, v7

    .line 1009
    nop

    .line 1010
    const-string v1, "m3VerticalLine"

    aput-object v1, v0, v8

    .line 1009
    nop

    .line 1010
    const-string v1, "m3Reshuffle"

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 1009
    nop

    .line 1008
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->M3_VARS:Ljava/util/List;

    .line 1024
    nop

    .line 1025
    new-array v0, v13, [[Ljava/lang/String;

    new-array v1, v7, [Ljava/lang/String;

    const-string v2, "gem1"

    aput-object v2, v1, v3

    const-string v2, "gem1"

    aput-object v2, v1, v4

    const-string v2, "sgc1x"

    aput-object v2, v1, v5

    const-string v2, "i"

    aput-object v2, v1, v6

    aput-object v1, v0, v3

    .line 1026
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "gem2"

    aput-object v9, v1, v3

    const-string v9, "gem2"

    aput-object v9, v1, v4

    const-string v9, "sgc2x"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v4

    .line 1025
    nop

    .line 1027
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "gem3"

    aput-object v9, v1, v3

    const-string v9, "gem3"

    aput-object v9, v1, v4

    const-string v9, "sgc3x"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v5

    .line 1025
    nop

    .line 1028
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "GoldBullion"

    aput-object v9, v1, v3

    const-string v9, "GoldBullionCounter"

    aput-object v9, v1, v4

    const-string v9, "sgbcx"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v6

    .line 1025
    nop

    .line 1029
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "SilverBullion"

    aput-object v9, v1, v3

    const-string v9, "SilverBullionCounter"

    aput-object v9, v1, v4

    const-string v9, "ssbcx"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v7

    .line 1025
    nop

    .line 1030
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "BronzeBullion"

    aput-object v9, v1, v3

    const-string v9, "BronzeBullionCounter"

    aput-object v9, v1, v4

    const-string v9, "sbbcx"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v8

    .line 1025
    nop

    .line 1031
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "PlatinumBullion"

    aput-object v9, v1, v3

    const-string v9, "PlatinumBullionCounter"

    aput-object v9, v1, v4

    const-string v9, "spbcx"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    const/4 v9, 0x6

    aput-object v1, v0, v9

    .line 1025
    nop

    .line 1032
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "m1"

    aput-object v9, v1, v3

    const-string v9, "m1"

    aput-object v9, v1, v4

    const-string v9, "sm1x"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v10

    .line 1025
    nop

    .line 1033
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "m2"

    aput-object v9, v1, v3

    const-string v9, "m2"

    aput-object v9, v1, v4

    const-string v9, "sm2x"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v11

    .line 1025
    nop

    .line 1034
    new-array v1, v7, [Ljava/lang/String;

    const-string v9, "m3"

    aput-object v9, v1, v3

    const-string v9, "m3"

    aput-object v9, v1, v4

    const-string v9, "sm3x"

    aput-object v9, v1, v5

    aput-object v2, v1, v6

    aput-object v1, v0, v12

    .line 1025
    check-cast v0, [Ljava/lang/Object;

    .line 1024
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->GEM_BULLION_FIELDS:Ljava/util/List;

    .line 1038
    nop

    .line 1039
    const/4 v0, 0x6

    new-array v0, v0, [[Ljava/lang/String;

    new-array v1, v6, [Ljava/lang/String;

    const-string v9, "o1"

    aput-object v9, v1, v3

    const-string v9, "o1"

    aput-object v9, v1, v4

    aput-object v2, v1, v5

    aput-object v1, v0, v3

    .line 1040
    new-array v1, v6, [Ljava/lang/String;

    const-string v9, "o2"

    aput-object v9, v1, v3

    const-string v9, "o2"

    aput-object v9, v1, v4

    aput-object v2, v1, v5

    aput-object v1, v0, v4

    .line 1039
    nop

    .line 1041
    new-array v1, v6, [Ljava/lang/String;

    const-string v9, "o3"

    aput-object v9, v1, v3

    const-string v9, "o3"

    aput-object v9, v1, v4

    aput-object v2, v1, v5

    aput-object v1, v0, v5

    .line 1039
    nop

    .line 1042
    new-array v1, v6, [Ljava/lang/String;

    const-string v9, "o4"

    aput-object v9, v1, v3

    const-string v9, "o4"

    aput-object v9, v1, v4

    aput-object v2, v1, v5

    aput-object v1, v0, v6

    .line 1039
    nop

    .line 1043
    new-array v1, v6, [Ljava/lang/String;

    const-string v9, "o5"

    aput-object v9, v1, v3

    const-string v9, "o5"

    aput-object v9, v1, v4

    aput-object v2, v1, v5

    aput-object v1, v0, v7

    .line 1039
    nop

    .line 1044
    new-array v1, v6, [Ljava/lang/String;

    const-string v6, "clovers"

    aput-object v6, v1, v3

    const-string v3, "clovers"

    aput-object v3, v1, v4

    aput-object v2, v1, v5

    aput-object v1, v0, v8

    .line 1039
    check-cast v0, [Ljava/lang/Object;

    .line 1038
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->PLAIN_ONLY_FIELDS:Ljava/util/List;

    .line 1501
    const-string v0, "<TimedEntityManager configVersion=\"1\">\n    <item entityType=\"CouponsM3\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"ShortContest2Note\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"WeeklyMissionsMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"MayorsQuestsMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"Competition1vs1Multiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"Merge2EnergyMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"ShortContestNote\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"BigContestCup\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"ExpeditionEnergyMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"ArcheryMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"EventScoreMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"RoomScoreMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"CascadeMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"SeasonMiniGameProgressMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n    <item entityType=\"RegataMiniGameProgressMultiplier\" timeEnd=\"{ts}\" multiplier=\"2.0000000000000000\" isAttemptsMode=\"0\" attemptsCount=\"0\"/>\n  </TimedEntityManager>"

    sput-object v0, Lcom/twntool/editor/core/XmlProcessor;->BOOSTER2X_TEMPLATE:Ljava/lang/String;

    sput v11, Lcom/twntool/editor/core/XmlProcessor;->$stable:I

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final addItems$lambda$27(Ljava/util/Map$Entry;)Ljava/lang/CharSequence;
    .registers 4
    .param p0, "it"  # Ljava/util/Map$Entry;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 337
    invoke-interface {p0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    invoke-interface {p0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ":"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method public static synthetic applyAcademiaIndustria$default(Lcom/twntool/editor/core/XmlProcessor;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Lkotlin/Pair;
    .registers 5

    .line 533
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_6

    const-string p2, "factories"

    :cond_6
    invoke-virtual {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->applyAcademiaIndustria(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object p0

    return-object p0
.end method

.method private static final applyAcademiaIndustria$replaceTags(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Ljava/util/Map;)Lkotlin/Pair;
    .registers 14
    .param p0, "body"  # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p1, "tagName"  # Ljava/lang/String;
    .param p2, "idMap"  # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 580
    new-instance v0, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 581
    .local v0, "count":Lkotlin/jvm/internal/Ref$IntRef;
    new-instance v1, Lkotlin/text/Regex;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "<"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\\b[^/]*/>"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 582
    .local v1, "pattern":Lkotlin/text/Regex;
    iget-object v2, p0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v4, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda7;

    invoke-direct {v4, p2, v0, p1}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda7;-><init>(Ljava/util/Map;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;)V

    invoke-virtual {v1, v2, v4}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v2

    .line 591
    .local v2, "newBody":Ljava/lang/String;
    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_38
    :goto_38
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_be

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .local v6, "tid":Ljava/lang/String;
    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 592
    .local v5, "attrs":Ljava/lang/String;
    new-instance v7, Lkotlin/text/Regex;

    sget-object v8, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v8, v6}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "\\b[^>]*id=\""

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 593
    .local v7, "existsRe":Lkotlin/text/Regex;
    move-object v8, v2

    check-cast v8, Ljava/lang/CharSequence;

    invoke-virtual {v7, v8}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_38

    .line 594
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\n    <"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " id=\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\" "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "/>"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 595
    iget v8, v0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    add-int/lit8 v8, v8, 0x1

    iput v8, v0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .end local v5  # "attrs":Ljava/lang/String;
    .end local v6  # "tid":Ljava/lang/String;
    .end local v7  # "existsRe":Lkotlin/text/Regex;
    goto/16 :goto_38

    .line 598
    :cond_be
    iget v3, v0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v2, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3
.end method

.method private static final applyAcademiaIndustria$replaceTags$lambda$30(Ljava/util/Map;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 9
    .param p0, "$idMap"  # Ljava/util/Map;
    .param p1, "$count"  # Lkotlin/jvm/internal/Ref$IntRef;
    .param p2, "$tagName"  # Ljava/lang/String;
    .param p3, "mr"  # Lkotlin/text/MatchResult;

    const-string v0, "mr"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 583
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "id=\"([^\"]*)\""

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {p3}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 584
    .local v0, "idM":Lkotlin/text/MatchResult;
    if-nez v0, :cond_22

    invoke-interface {p3}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    return-object v1

    .line 585
    :cond_22
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x1

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 586
    .local v1, "tid":Ljava/lang/String;
    invoke-interface {p0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    if-nez v3, :cond_3c

    invoke-interface {p3}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    return-object v2

    .line 587
    .local v3, "attrs":Ljava/lang/String;
    :cond_3c
    iget v4, p1, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    add-int/2addr v4, v2

    iput v4, p1, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .line 588
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " id=\""

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\" "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "/>"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    return-object v2
.end method

.method private final applyChatEmoji(Ljava/lang/String;)Ljava/lang/String;
    .registers 12
    .param p1, "xml"  # Ljava/lang/String;

    .line 175
    sget-object v0, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v0}, Lcom/twntool/editor/data/SkinData;->getCHAT_EMOJI_VALUE()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "<Var name=\"UnlockedChatEmoji\" v=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\"/>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 176
    .local v0, "novoVar":Ljava/lang/String;
    new-instance v1, Lkotlin/text/Regex;

    const-string v2, "<Var\\s+name=\"UnlockedChatEmoji\"[^/]*/>"

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v1, v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 177
    .local v1, "rx":Lkotlin/text/Regex;
    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_39

    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2, v0}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 178
    :cond_39
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "</Global\\s*>"

    sget-object v4, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v2, v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, p1

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    const/4 v5, 0x2

    const/4 v6, 0x0

    invoke-static {v2, v3, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 179
    .local v2, "mG":Lkotlin/text/MatchResult;
    const-string v3, "substring(...)"

    if-eqz v2, :cond_84

    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {p1, v4, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {p1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 180
    :cond_84
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "</root\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v7, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v7, v8, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 181
    .local v5, "mR":Lkotlin/text/MatchResult;
    if-eqz v5, :cond_ca

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {p1, v4, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {p1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 182
    :cond_ca
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method private static final applyMinhasCartas$sub(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 6
    .param p0, "text"  # Ljava/lang/String;
    .param p1, "campo"  # Ljava/lang/String;

    .line 793
    new-instance v0, Lkotlin/text/Regex;

    .line 794
    sget-object v1, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v1, p1}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "(<DataElem\\s+name=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"\\s+type=\"\\w+\"\\s+value=\")[^\"]*?(\")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 793
    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 796
    move-object v1, p0

    check-cast v1, Ljava/lang/CharSequence;

    new-instance v2, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda18;

    invoke-direct {v2}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda18;-><init>()V

    invoke-virtual {v0, v1, v2}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v0

    .line 793
    return-object v0
.end method

.method private static final applyMinhasCartas$sub$lambda$37(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 4
    .param p0, "mr"  # Lkotlin/text/MatchResult;

    const-string v0, "mr"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 797
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x2

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "461"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final applyTodasCartas$cardId(I)Ljava/lang/String;
    .registers 3
    .param p0, "n"  # I

    .line 705
    const/16 v0, 0xa

    if-ge p0, v0, :cond_c

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "card_0"

    goto :goto_13

    :cond_c
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "card_"

    :goto_13
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static final applyTodasCartas$lambda$31(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 4
    .param p0, "mr"  # Lkotlin/text/MatchResult;

    const-string v0, "mr"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 710
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x3

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "461"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final applyTodasCartas$lambda$32(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 3
    .param p0, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 715
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private static final applyTodasCartas$lambda$36(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 3
    .param p0, "cid"  # Ljava/lang/String;

    const-string v0, "cid"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 733
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "            <DataElem type=\"dataStore\">\n              <DataElem name=\"cardId\" type=\"string\" value=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\"/>\n              <DataElem name=\"generatedCount\" type=\"int\" value=\"461\"/>\n              <DataElem name=\"inStockCount\" type=\"int\" value=\"461\"/>\n              <DataElem name=\"isNew\" type=\"bool\" value=\"false\"/>\n              <DataElem name=\"maxInStockCount\" type=\"int\" value=\"461\"/>\n            </DataElem>\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    .line 738
    return-object v0
.end method

.method public static synthetic applyTodasVantagens$default(Lcom/twntool/editor/core/XmlProcessor;Ljava/lang/String;Ljava/util/Set;ILjava/lang/Object;)Lkotlin/Pair;
    .registers 5

    .line 823
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_5

    .line 825
    const/4 p2, 0x0

    .line 823
    :cond_5
    invoke-virtual {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasVantagens(Ljava/lang/String;Ljava/util/Set;)Lkotlin/Pair;

    move-result-object p0

    return-object p0
.end method

.method private static final applyTodasVantagens$lambda$39(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 3
    .param p0, "it"  # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 848
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "        "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final applyTodasVantagens$lambda$40(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 3
    .param p0, "it"  # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 852
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "        "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private final insertVarTyped(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 15
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "name"  # Ljava/lang/String;
    .param p3, "value"  # Ljava/lang/String;
    .param p4, "type"  # Ljava/lang/String;

    .line 424
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "<Var name=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" v=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" t=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\"/>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 425
    .local v0, "tag":Ljava/lang/String;
    new-instance v1, Lkotlin/text/Regex;

    const-string v2, "</Global\\s*>"

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v1, v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-static {v1, v2, v3, v4, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 426
    .local v1, "mGlobal":Lkotlin/text/MatchResult;
    const-string v2, "\n"

    const-string v6, "substring(...)"

    if-eqz v1, :cond_7e

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 427
    :cond_7e
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "</root\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v7, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v7, v8, v3, v4, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 428
    .local v4, "mRoot":Lkotlin/text/MatchResult;
    if-eqz v4, :cond_c8

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {p1, v3, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {p1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 429
    :cond_c8
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method static synthetic insertVarTyped$default(Lcom/twntool/editor/core/XmlProcessor;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;
    .registers 7

    .line 423
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_6

    const-string p4, "i"

    :cond_6
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/twntool/editor/core/XmlProcessor;->insertVarTyped(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic processMarketSlots$default(Lcom/twntool/editor/core/XmlProcessor;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Pair;
    .registers 5

    .line 1459
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_6

    const/16 p2, 0x64

    :cond_6
    invoke-virtual {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->processMarketSlots(Ljava/lang/String;I)Lkotlin/Pair;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic processRegata$default(Lcom/twntool/editor/core/XmlProcessor;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Pair;
    .registers 5

    .line 61
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_6

    const/16 p2, 0x69

    :cond_6
    invoke-virtual {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->processRegata(Ljava/lang/String;I)Lkotlin/Pair;

    move-result-object p0

    return-object p0
.end method

.method private static final processRegataApk$resetVar(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 8
    .param p0, "bloco"  # Ljava/lang/String;
    .param p1, "nome"  # Ljava/lang/String;

    .line 1437
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "<Var name=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" v=\"0\" t=\"b\"/>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1438
    .local v0, "repl":Ljava/lang/String;
    new-instance v1, Lkotlin/text/Regex;

    sget-object v2, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v2, p1}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<Var\\s+name=\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\"\\s+v=\"[^\"]*\"[^>]*/>"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v1, v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1439
    .local v1, "rx":Lkotlin/text/Regex;
    move-object v2, p0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_50

    move-object v2, p0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2, v0}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_71

    .line 1440
    :cond_50
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "(?i)</Vars>"

    invoke-direct {v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, p0

    check-cast v3, Ljava/lang/CharSequence;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\n</Vars>"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 1439
    :goto_71
    return-object v2
.end method

.method private static final replaceValue$lambda$2(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 4
    .param p0, "$hits"  # Lkotlin/jvm/internal/Ref$IntRef;
    .param p1, "$safeValue"  # Ljava/lang/String;
    .param p2, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    iget v0, p0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    invoke-static {p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue$replaceFn(Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final replaceValue$lambda$3(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 4
    .param p0, "$hits"  # Lkotlin/jvm/internal/Ref$IntRef;
    .param p1, "$safeValue"  # Ljava/lang/String;
    .param p2, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 45
    iget v0, p0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    invoke-static {p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue$replaceFn(Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final replaceValue$replaceFn(Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 6
    .param p0, "safeValue"  # Ljava/lang/String;
    .param p1, "match"  # Lkotlin/text/MatchResult;

    .line 39
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "v=\"[^\"]*\""

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {p1}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "v=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static final setM3Quantities$lambda$43(Ljava/lang/String;Ljava/lang/String;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 14
    .param p0, "$safeVar"  # Ljava/lang/String;
    .param p1, "$newVar"  # Ljava/lang/String;
    .param p2, "mr"  # Lkotlin/text/MatchResult;

    const-string v0, "mr"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1181
    invoke-interface {p2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x2

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1182
    .local v0, "inner":Ljava/lang/String;
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "(<Vars\\b[^>]*>)((?:.|\\n)*?)(</Vars>)"

    invoke-direct {v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1183
    .local v2, "varsBlockRe":Lkotlin/text/Regex;
    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v2, v3, v5, v1, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1184
    .local v3, "vm":Lkotlin/text/MatchResult;
    const/4 v4, 0x3

    const/4 v6, 0x1

    if-eqz v3, :cond_c5

    .line 1185
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v7

    invoke-interface {v7, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1186
    .local v1, "innerVars":Ljava/lang/String;
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "<Var\\b[^>]*\\bname=\"Lives_infTime_Match3\""

    invoke-direct {v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-virtual {v7, v8}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_50

    .line 1187
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "<Var\\b[^>]*\\bname=\"Lives_infTime_Match3\"[^>]*/>"

    invoke-direct {v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {p0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v7, v8, p0}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_76

    .line 1189
    :cond_50
    move-object v7, v1

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v7}, Lkotlin/text/StringsKt;->trimEnd(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\n"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1191
    :goto_76
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {v0, v5, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v7, "substring(...)"

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v9

    invoke-interface {v9, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v10

    add-int/2addr v10, v6

    invoke-virtual {v0, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .end local v1  # "innerVars":Ljava/lang/String;
    goto :goto_c6

    .line 1192
    :cond_c5
    move-object v1, v0

    .line 1184
    :goto_c6
    move-object v0, v1

    .line 1193
    invoke-interface {p2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {p2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    return-object v1
.end method

.method private static final setM3Quantities$lambda$44(Ljava/lang/Long;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 5
    .param p0, "$tjAmount"  # Ljava/lang/Long;
    .param p1, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1298
    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x2

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "quoteReplacement(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final unlockAchievements$lambda$42(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 3
    .param p0, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 955
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private static final unlockAvatars$lambda$4(Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 5
    .param p0, "$atualizados"  # Lkotlin/jvm/internal/Ref$IntRef;
    .param p1, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 103
    iget v0, p0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .line 104
    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 105
    .local v0, "name":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "<Var name=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" v=\"1\" t=\"b\"/>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    return-object v1
.end method

.method private static final unlockAvatars$lambda$5(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 3
    .param p0, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 108
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private static final unlockAvatars$lambda$8(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 3
    .param p0, "it"  # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 113
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "    <Var name=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" v=\"1\" t=\"b\"/>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final unlockBuildingSkins$lambda$9(Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 3
    .param p0, "it"  # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 131
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  <Building id=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" count=\"10\"/>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method public static synthetic unlockProfile$default(Lcom/twntool/editor/core/XmlProcessor;Ljava/lang/String;Ljava/util/Map;ILjava/lang/Object;)Lkotlin/Pair;
    .registers 5

    .line 219
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_5

    .line 221
    const/4 p2, 0x0

    .line 219
    :cond_5
    invoke-virtual {p0, p1, p2}, Lcom/twntool/editor/core/XmlProcessor;->unlockProfile(Ljava/lang/String;Ljava/util/Map;)Lkotlin/Pair;

    move-result-object p0

    return-object p0
.end method

.method private static final unlockProfile$lambda$22(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 13
    .param p0, "$novosPorCategoria"  # Ljava/util/LinkedHashMap;
    .param p1, "it"  # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 281
    sget-object v0, Lcom/twntool/editor/data/ProfileData;->INSTANCE:Lcom/twntool/editor/data/ProfileData;

    move-object v1, p0

    check-cast v1, Ljava/util/Map;

    invoke-static {v1, p1}, Lkotlin/collections/MapsKt;->getValue(Ljava/util/Map;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Ljava/lang/Iterable;

    const-string v1, ","

    move-object v3, v1

    check-cast v3, Ljava/lang/CharSequence;

    const/16 v9, 0x3e

    const/4 v10, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v2 .. v10}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/twntool/editor/data/ProfileData;->dataElemTag(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final unlockProfile$lambda$24(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 13
    .param p0, "$novosPorCategoria"  # Ljava/util/LinkedHashMap;
    .param p1, "it"  # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 294
    sget-object v0, Lcom/twntool/editor/data/ProfileData;->INSTANCE:Lcom/twntool/editor/data/ProfileData;

    move-object v1, p0

    check-cast v1, Ljava/util/Map;

    invoke-static {v1, p1}, Lkotlin/collections/MapsKt;->getValue(Ljava/util/Map;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Ljava/lang/Iterable;

    const-string v1, ","

    move-object v3, v1

    check-cast v3, Ljava/lang/CharSequence;

    const/16 v9, 0x3e

    const/4 v10, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v2 .. v10}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/twntool/editor/data/ProfileData;->dataElemTag(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final unlockProfile$lambda$25(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/CharSequence;
    .registers 6
    .param p0, "$novosPorCategoria"  # Ljava/util/LinkedHashMap;
    .param p1, "it"  # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 303
    invoke-virtual {p0, p1}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    if-eqz v0, :cond_12

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    goto :goto_13

    :cond_12
    const/4 v0, 0x0

    .line 304
    .local v0, "n":I
    :goto_13
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_6e

    :goto_1a
    goto :goto_4b

    :sswitch_1b
    const-string v1, "UnlockedExpRanks"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_24

    goto :goto_1a

    .line 306
    :cond_24
    const-string v1, "Títulos"

    goto :goto_4c

    .line 304
    :sswitch_27
    const-string v1, "UnlockedStyles"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_30

    goto :goto_1a

    .line 308
    :cond_30
    const-string v1, "Estilos"

    goto :goto_4c

    .line 304
    :sswitch_33
    const-string v1, "UnlockedFrames"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3c

    goto :goto_1a

    .line 307
    :cond_3c
    const-string v1, "Molduras"

    goto :goto_4c

    .line 304
    :sswitch_3f
    const-string v1, "UnlockedBadges"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_48

    goto :goto_1a

    .line 305
    :cond_48
    const-string v1, "Badges"

    goto :goto_4c

    .line 309
    :goto_4b
    move-object v1, p1

    .line 304
    :goto_4c
    nop

    .line 311
    .local v1, "nice":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    return-object v2

    nop

    :sswitch_data_6e
    .sparse-switch
        -0x2a0739ed -> :sswitch_3f
        -0x22458e77 -> :sswitch_33
        -0xbef7a3b -> :sswitch_27
        0x4682c9cd -> :sswitch_1b
    .end sparse-switch
.end method

.method private static final unlockTerrenos$lambda$45(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 8
    .param p0, "m"  # Lkotlin/text/MatchResult;

    const-string v0, "m"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1332
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/16 v2, 0x6e

    const/16 v3, 0x79

    const/4 v4, 0x0

    invoke-static/range {v1 .. v6}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;CCZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "d=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private final upsertVarTyped(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 21
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "name"  # Ljava/lang/String;
    .param p3, "value"  # Ljava/lang/String;
    .param p4, "tipo"  # Ljava/lang/String;

    .line 994
    move-object/from16 v0, p1

    move-object/from16 v1, p2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "<Var name=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" v=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v3, p3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\" t=\""

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v4, p4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "\"/>"

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 995
    .local v2, "newTag":Ljava/lang/String;
    invoke-static {v2}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 996
    .local v5, "safe":Ljava/lang/String;
    new-instance v6, Lkotlin/text/Regex;

    sget-object v7, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v7, v1}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "<Var\\s+name=\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\"[^/]*/>"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v6, v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 997
    .local v6, "pattern":Lkotlin/text/Regex;
    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    invoke-virtual {v6, v7}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_73

    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v6, v7, v5}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    return-object v7

    .line 998
    :cond_73
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "</Global\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v7, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v8, v0

    check-cast v8, Ljava/lang/CharSequence;

    const/4 v9, 0x0

    const/4 v10, 0x2

    const/4 v11, 0x0

    invoke-static {v7, v8, v9, v10, v11}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 999
    .local v7, "mG":Lkotlin/text/MatchResult;
    const-string v8, "\n"

    const-string v12, "substring(...)"

    if-eqz v7, :cond_c4

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    invoke-virtual {v0, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    invoke-virtual {v0, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    return-object v8

    .line 1000
    :cond_c4
    new-instance v13, Lkotlin/text/Regex;

    const-string v14, "</root\\s*>"

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v13, v14, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v14, v0

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v13, v14, v9, v10, v11}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    .line 1001
    .local v10, "mR":Lkotlin/text/MatchResult;
    if-eqz v10, :cond_10e

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-virtual {v0, v9, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-virtual {v0, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    goto :goto_10f

    :cond_10e
    move-object v8, v0

    :goto_10f
    return-object v8
.end method


# virtual methods
.method public final activateSeasonPass(Ljava/lang/String;)Lkotlin/Pair;
    .registers 14
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 354
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "<SeasonTicket\\b([^/>]*?)(/?)>"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 355
    .local v0, "rx":Lkotlin/text/Regex;
    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    if-nez v1, :cond_21

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {p1, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    return-object v1

    .line 356
    .local v1, "m":Lkotlin/text/MatchResult;
    :cond_21
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    const/4 v6, 0x1

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 357
    .local v5, "attrs":Ljava/lang/String;
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v7

    invoke-interface {v7, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 358
    .local v7, "close":Ljava/lang/String;
    move-object v8, v5

    .line 359
    .local v8, "newAttrs":Ljava/lang/String;
    move-object v9, v8

    check-cast v9, Ljava/lang/CharSequence;

    const-string v10, "premium="

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v9, v10, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_55

    .line 360
    new-instance v9, Lkotlin/text/Regex;

    const-string v10, "premium=\"[^\"]*\""

    invoke-direct {v9, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v10, v8

    check-cast v10, Ljava/lang/CharSequence;

    const-string v11, "premium=\"1\""

    invoke-virtual {v9, v10, v11}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    goto :goto_68

    .line 361
    :cond_55
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " premium=\"1\""

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 359
    :goto_68
    move-object v8, v9

    .line 362
    move-object v9, v8

    check-cast v9, Ljava/lang/CharSequence;

    const-string v10, "score="

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v9, v10, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_87

    .line 363
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "score=\"[^\"]*\""

    invoke-direct {v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v8

    check-cast v3, Ljava/lang/CharSequence;

    const-string v4, "score=\"1002\""

    invoke-virtual {v2, v3, v4}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_9a

    .line 364
    :cond_87
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " score=\"1002\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 362
    :goto_9a
    nop

    .line 365
    .end local v8  # "newAttrs":Ljava/lang/String;
    .local v2, "newAttrs":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<SeasonTicket"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ">"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 366
    .local v3, "replacement":Ljava/lang/String;
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    move-object v9, v3

    check-cast v9, Ljava/lang/CharSequence;

    invoke-static {v8, v4, v9}, Lkotlin/text/StringsKt;->replaceRange(Ljava/lang/CharSequence;Lkotlin/ranges/IntRange;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-static {v4, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4
.end method

.method public final addItems(Ljava/lang/String;Ljava/util/Map;)Lkotlin/Pair;
    .registers 34
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "items"  # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;)",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-string v2, "xml"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v2, "items"

    move-object/from16 v3, p2

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 318
    move-object/from16 v2, p2

    .local v2, "$this$filterValues$iv":Ljava/util/Map;
    const/4 v4, 0x0

    .line 1553
    .local v4, "$i$f$filterValues":I
    new-instance v5, Ljava/util/LinkedHashMap;

    invoke-direct {v5}, Ljava/util/LinkedHashMap;-><init>()V

    .line 1554
    .local v5, "result$iv":Ljava/util/LinkedHashMap;
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_20
    :goto_20
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    const/4 v8, 0x1

    const/4 v9, 0x0

    if-eqz v7, :cond_4b

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Map$Entry;

    .line 1555
    .local v7, "entry$iv":Ljava/util/Map$Entry;
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Number;

    invoke-virtual {v10}, Ljava/lang/Number;->intValue()I

    move-result v10

    .local v10, "it":I
    const/4 v11, 0x0

    .line 318
    .local v11, "$i$a$-filterValues-XmlProcessor$addItems$filtered$1":I
    if-lez v10, :cond_3c

    goto :goto_3d

    :cond_3c
    move v8, v9

    .line 1555
    .end local v10  # "it":I
    .end local v11  # "$i$a$-filterValues-XmlProcessor$addItems$filtered$1":I
    :goto_3d
    if-eqz v8, :cond_20

    .line 1556
    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v8

    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v5, v8, v9}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_20

    .line 1559
    .end local v7  # "entry$iv":Ljava/util/Map$Entry;
    :cond_4b
    move-object v2, v5

    check-cast v2, Ljava/util/Map;

    .line 318
    .end local v2  # "$this$filterValues$iv":Ljava/util/Map;
    .end local v4  # "$i$f$filterValues":I
    .end local v5  # "result$iv":Ljava/util/LinkedHashMap;
    nop

    .line 319
    .local v2, "filtered":Ljava/util/Map;
    invoke-interface {v2}, Ljava/util/Map;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_6a

    sget-object v4, Lcom/twntool/editor/data/Strings;->INSTANCE:Lcom/twntool/editor/data/Strings;

    sget-object v5, Lcom/twntool/editor/data/AppState;->INSTANCE:Lcom/twntool/editor/data/AppState;

    invoke-virtual {v5}, Lcom/twntool/editor/data/AppState;->getLang()Ljava/lang/String;

    move-result-object v5

    const-string v6, "sel_none"

    new-array v7, v9, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6, v7}, Lcom/twntool/editor/data/Strings;->t(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v1, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4

    .line 321
    :cond_6a
    const-string v4, "GivingOffersDeferred"

    invoke-virtual {v0, v1, v4}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_74

    const-string v5, ""

    .line 322
    .local v5, "atual":Ljava/lang/String;
    :cond_74
    new-instance v6, Ljava/util/LinkedHashMap;

    invoke-direct {v6}, Ljava/util/LinkedHashMap;-><init>()V

    .line 323
    .local v6, "merged":Ljava/util/LinkedHashMap;
    move-object v7, v5

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v7}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v7

    xor-int/2addr v7, v8

    const/4 v10, 0x0

    const/4 v11, 0x2

    const-string v12, ","

    if-eqz v7, :cond_115

    .line 324
    move-object v13, v5

    check-cast v13, Ljava/lang/CharSequence;

    new-array v14, v8, [Ljava/lang/String;

    aput-object v12, v14, v9

    const/16 v17, 0x6

    const/16 v18, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    invoke-static/range {v13 .. v18}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_9d
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_115

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    .line 325
    .local v13, "parte":Ljava/lang/String;
    move-object v14, v13

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v14}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v14

    .line 326
    .local v14, "p":Ljava/lang/String;
    move-object v15, v14

    check-cast v15, Ljava/lang/CharSequence;

    const-string v16, ":"

    move-object/from16 v8, v16

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v15, v8, v9, v11, v10}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_110

    .line 327
    move-object/from16 v18, v14

    check-cast v18, Ljava/lang/CharSequence;

    const/4 v8, 0x1

    new-array v15, v8, [Ljava/lang/String;

    aput-object v16, v15, v9

    const/16 v22, 0x2

    const/16 v23, 0x0

    const/16 v20, 0x0

    const/16 v21, 0x2

    move-object/from16 v19, v15

    invoke-static/range {v18 .. v23}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v8

    .line 328
    .local v8, "parts":Ljava/util/List;
    invoke-interface {v8, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 329
    .local v15, "k":Ljava/lang/String;
    const/4 v10, 0x1

    invoke-interface {v8, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v17

    check-cast v17, Ljava/lang/String;

    .line 330
    .local v17, "v":Ljava/lang/String;
    move-object/from16 v18, v17

    check-cast v18, Ljava/lang/CharSequence;

    invoke-static/range {v18 .. v18}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v18

    invoke-static/range {v18 .. v18}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    .line 331
    .local v10, "n":Ljava/lang/Integer;
    if-eqz v10, :cond_10b

    move-object v11, v6

    check-cast v11, Ljava/util/Map;

    move-object/from16 v20, v15

    check-cast v20, Ljava/lang/CharSequence;

    invoke-static/range {v20 .. v20}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-interface {v11, v9, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_10b
    const/4 v8, 0x1

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x2

    goto :goto_9d

    .line 326
    .end local v8  # "parts":Ljava/util/List;
    .end local v10  # "n":Ljava/lang/Integer;
    .end local v15  # "k":Ljava/lang/String;
    .end local v17  # "v":Ljava/lang/String;
    :cond_110
    const/4 v8, 0x1

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x2

    goto :goto_9d

    .line 335
    .end local v13  # "parte":Ljava/lang/String;
    .end local v14  # "p":Ljava/lang/String;
    :cond_115
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_11d
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_144

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .local v9, "k":Ljava/lang/String;
    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Number;

    invoke-virtual {v8}, Ljava/lang/Number;->intValue()I

    move-result v8

    .local v8, "v":I
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    move-object v11, v6

    check-cast v11, Ljava/util/Map;

    invoke-interface {v11, v9, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_11d

    .line 337
    .end local v8  # "v":I
    .end local v9  # "k":Ljava/lang/String;
    :cond_144
    invoke-virtual {v6}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v7

    const-string v8, "<get-entries>(...)"

    invoke-static {v7, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v22, v7

    check-cast v22, Ljava/lang/Iterable;

    move-object/from16 v23, v12

    check-cast v23, Ljava/lang/CharSequence;

    new-instance v28, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda15;

    invoke-direct/range {v28 .. v28}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda15;-><init>()V

    const/16 v29, 0x1e

    const/16 v30, 0x0

    const/16 v24, 0x0

    const/16 v25, 0x0

    const/16 v26, 0x0

    const/16 v27, 0x0

    invoke-static/range {v22 .. v30}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 338
    .local v7, "csv":Ljava/lang/String;
    invoke-virtual {v0, v1, v4, v7}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .local v8, "out":Ljava/lang/String;
    invoke-virtual {v4}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    .line 339
    .local v4, "ok":Z
    const-string v9, "substring(...)"

    if-eqz v4, :cond_1cd

    .line 340
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v10

    const/16 v11, 0x50

    if-le v10, v11, :cond_1a6

    const/4 v10, 0x0

    invoke-virtual {v7, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "..."

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    goto :goto_1a7

    :cond_1a6
    move-object v9, v7

    .line 341
    .local v9, "preview":Ljava/lang/String;
    :goto_1a7
    invoke-virtual {v6}, Ljava/util/LinkedHashMap;->size()I

    move-result v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "✔ GivingOffersDeferred → "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " itens: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v8, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v10

    return-object v10

    .line 343
    .end local v9  # "preview":Ljava/lang/String;
    :cond_1cd
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "<Var name=\"GivingOffersDeferred\" v=\""

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "\"/>"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 344
    .local v10, "novoVar":Ljava/lang/String;
    new-instance v11, Lkotlin/text/Regex;

    const-string v12, "</Global\\s*>"

    sget-object v13, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v11, v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v12, v1

    check-cast v12, Ljava/lang/CharSequence;

    const/4 v13, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    invoke-static {v11, v12, v15, v14, v13}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v11

    .line 345
    .local v11, "mG":Lkotlin/text/MatchResult;
    if-eqz v11, :cond_256

    .line 346
    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v12

    invoke-virtual {v1, v15, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v13, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v14

    invoke-virtual {v14}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v14

    invoke-virtual {v1, v14}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 347
    .local v9, "newXml":Ljava/lang/String;
    invoke-virtual {v6}, Ljava/util/LinkedHashMap;->size()I

    move-result v12

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "✔ GivingOffersDeferred criado em <Global> com "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, " itens."

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v9, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    return-object v12

    .line 349
    .end local v9  # "newXml":Ljava/lang/String;
    :cond_256
    const-string v9, "❌ Não foi possível encontrar ou criar GivingOffersDeferred."

    invoke-static {v1, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    return-object v9
.end method

.method public final applyAcademiaIndustria(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;
    .registers 22
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "mode"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const-string v2, "xml"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v2, "mode"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 535
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "(<Upgrade\\b[^>]*>)(.*?)(</Upgrade>)"

    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v2, v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    const/4 v5, 0x2

    const/4 v6, 0x0

    invoke-static {v2, v3, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 537
    .local v2, "full":Lkotlin/text/MatchResult;
    if-nez v2, :cond_32

    new-instance v3, Lkotlin/text/Regex;

    const-string v7, "<Upgrade\\b([^>]*)/>"

    invoke-direct {v3, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v3, v7, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    goto :goto_33

    :cond_32
    move-object v3, v6

    .line 539
    .local v3, "self":Lkotlin/text/MatchResult;
    :goto_33
    const/4 v7, 0x0

    .line 540
    .local v7, "pre":Ljava/lang/String;
    const/4 v8, 0x0

    .line 541
    .local v8, "openTag":Ljava/lang/String;
    new-instance v9, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v9}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 542
    .local v9, "body":Lkotlin/jvm/internal/Ref$ObjectRef;
    const/4 v10, 0x0

    .line 543
    .local v10, "closeTag":Ljava/lang/String;
    const/4 v11, 0x0

    .line 545
    .local v11, "post":Ljava/lang/String;
    nop

    .line 546
    const/4 v12, 0x1

    const-string v13, "substring(...)"

    if-eqz v2, :cond_84

    .line 547
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v0, v4, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 548
    .end local v7  # "pre":Ljava/lang/String;
    .local v4, "pre":Ljava/lang/String;
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v6

    invoke-interface {v6, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 549
    .end local v8  # "openTag":Ljava/lang/String;
    .local v6, "openTag":Ljava/lang/String;
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v7

    invoke-interface {v7, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    iput-object v5, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 550
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    const/4 v7, 0x3

    invoke-interface {v5, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 551
    .end local v10  # "closeTag":Ljava/lang/String;
    .local v5, "closeTag":Ljava/lang/String;
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v7

    add-int/2addr v7, v12

    invoke-virtual {v0, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v16, v2

    .end local v11  # "post":Ljava/lang/String;
    .local v7, "post":Ljava/lang/String;
    goto/16 :goto_154

    .line 553
    .end local v4  # "pre":Ljava/lang/String;
    .end local v5  # "closeTag":Ljava/lang/String;
    .end local v6  # "openTag":Ljava/lang/String;
    .local v7, "pre":Ljava/lang/String;
    .restart local v8  # "openTag":Ljava/lang/String;
    .restart local v10  # "closeTag":Ljava/lang/String;
    .restart local v11  # "post":Ljava/lang/String;
    :cond_84
    const-string v14, ""

    if-eqz v3, :cond_f5

    .line 554
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    .line 555
    .local v5, "attrs":Ljava/lang/String;
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v0, v4, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 556
    .end local v7  # "pre":Ljava/lang/String;
    .local v6, "pre":Ljava/lang/String;
    move-object v7, v5

    check-cast v7, Ljava/lang/CharSequence;

    invoke-interface {v7}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-lez v7, :cond_b5

    move v4, v12

    :cond_b5
    if-eqz v4, :cond_d1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "<Upgrade "

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, ">"

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_d3

    :cond_d1
    const-string v4, "<Upgrade>"

    .line 557
    .end local v8  # "openTag":Ljava/lang/String;
    .local v4, "openTag":Ljava/lang/String;
    :goto_d3
    iput-object v14, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 558
    const-string v7, "</Upgrade>"

    .line 559
    .end local v10  # "closeTag":Ljava/lang/String;
    .local v7, "closeTag":Ljava/lang/String;
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v8

    add-int/2addr v8, v12

    invoke-virtual {v0, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v5, v8

    move-object/from16 v16, v2

    move-object/from16 v17, v6

    move-object v6, v4

    move-object/from16 v4, v17

    move-object/from16 v18, v7

    move-object v7, v5

    move-object/from16 v5, v18

    .end local v11  # "post":Ljava/lang/String;
    .local v5, "post":Ljava/lang/String;
    goto :goto_154

    .line 564
    .end local v4  # "openTag":Ljava/lang/String;
    .end local v5  # "post":Ljava/lang/String;
    .end local v6  # "pre":Ljava/lang/String;
    .local v7, "pre":Ljava/lang/String;
    .restart local v8  # "openTag":Ljava/lang/String;
    .restart local v10  # "closeTag":Ljava/lang/String;
    .restart local v11  # "post":Ljava/lang/String;
    :cond_f5
    new-instance v12, Lkotlin/text/Regex;

    const-string v15, "</Player\\s*>"

    sget-object v4, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v12, v15, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v15, 0x0

    invoke-static {v12, v4, v15, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 565
    .local v4, "mPlayer":Lkotlin/text/MatchResult;
    new-instance v12, Lkotlin/text/Regex;

    const-string v5, "</root\\s*>"

    sget-object v6, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v12, v5, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v5, v0

    check-cast v5, Ljava/lang/CharSequence;

    move-object/from16 v16, v2

    const/4 v2, 0x0

    const/4 v6, 0x2

    .end local v2  # "full":Lkotlin/text/MatchResult;
    .local v16, "full":Lkotlin/text/MatchResult;
    invoke-static {v12, v5, v15, v6, v2}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 566
    .local v2, "mRoot":Lkotlin/text/MatchResult;
    if-nez v4, :cond_11e

    move-object v5, v2

    goto :goto_11f

    :cond_11e
    move-object v5, v4

    .line 567
    .local v5, "anchor":Lkotlin/text/MatchResult;
    :goto_11f
    if-nez v5, :cond_12b

    const/4 v6, 0x0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-static {v0, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    return-object v6

    .line 568
    :cond_12b
    const/4 v6, 0x0

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v12

    invoke-virtual {v0, v6, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 569
    .end local v7  # "pre":Ljava/lang/String;
    .restart local v6  # "pre":Ljava/lang/String;
    const-string v7, "<Upgrade version=\"4\">"

    .line 570
    .end local v8  # "openTag":Ljava/lang/String;
    .local v7, "openTag":Ljava/lang/String;
    iput-object v14, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 571
    const-string v8, "</Upgrade>"

    .line 572
    .end local v10  # "closeTag":Ljava/lang/String;
    .local v8, "closeTag":Ljava/lang/String;
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    invoke-virtual {v0, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v6

    move-object v6, v7

    move-object v5, v8

    move-object v7, v10

    .line 576
    .end local v2  # "mRoot":Lkotlin/text/MatchResult;
    .end local v8  # "closeTag":Ljava/lang/String;
    .end local v11  # "post":Ljava/lang/String;
    .local v4, "pre":Ljava/lang/String;
    .local v5, "closeTag":Ljava/lang/String;
    .local v6, "openTag":Ljava/lang/String;
    .local v7, "post":Ljava/lang/String;
    :goto_154
    const/4 v2, 0x0

    .line 601
    .local v2, "total":I
    const-string v8, "factories"

    invoke-static {v1, v8}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    const-string v10, "all"

    if-nez v8, :cond_165

    invoke-static {v1, v10}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_180

    .line 602
    :cond_165
    const-string v8, "Factory"

    sget-object v11, Lcom/twntool/editor/core/XmlProcessor;->ACADEMIA_FACTORIES:Ljava/util/Map;

    invoke-static {v9, v8, v11}, Lcom/twntool/editor/core/XmlProcessor;->applyAcademiaIndustria$replaceTags(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Ljava/util/Map;)Lkotlin/Pair;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .local v11, "b":Ljava/lang/String;
    invoke-virtual {v8}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Number;

    invoke-virtual {v8}, Ljava/lang/Number;->intValue()I

    move-result v8

    .local v8, "n":I
    iput-object v11, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    add-int/2addr v2, v8

    .line 604
    .end local v8  # "n":I
    .end local v11  # "b":Ljava/lang/String;
    :cond_180
    const-string v8, "trains"

    invoke-static {v1, v8}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_18e

    invoke-static {v1, v10}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1a9

    .line 605
    :cond_18e
    const-string v8, "Train"

    sget-object v11, Lcom/twntool/editor/core/XmlProcessor;->ACADEMIA_TRAINS:Ljava/util/Map;

    invoke-static {v9, v8, v11}, Lcom/twntool/editor/core/XmlProcessor;->applyAcademiaIndustria$replaceTags(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Ljava/util/Map;)Lkotlin/Pair;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .restart local v11  # "b":Ljava/lang/String;
    invoke-virtual {v8}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Number;

    invoke-virtual {v8}, Ljava/lang/Number;->intValue()I

    move-result v8

    .restart local v8  # "n":I
    iput-object v11, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    add-int/2addr v2, v8

    .line 607
    .end local v8  # "n":I
    .end local v11  # "b":Ljava/lang/String;
    :cond_1a9
    const-string v8, "islands"

    invoke-static {v1, v8}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_1b7

    invoke-static {v1, v10}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1d2

    .line 608
    :cond_1b7
    const-string v8, "Island"

    sget-object v10, Lcom/twntool/editor/core/XmlProcessor;->ACADEMIA_ISLANDS:Ljava/util/Map;

    invoke-static {v9, v8, v10}, Lcom/twntool/editor/core/XmlProcessor;->applyAcademiaIndustria$replaceTags(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Ljava/util/Map;)Lkotlin/Pair;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .local v10, "b":Ljava/lang/String;
    invoke-virtual {v8}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Number;

    invoke-virtual {v8}, Ljava/lang/Number;->intValue()I

    move-result v8

    .restart local v8  # "n":I
    iput-object v10, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    add-int/2addr v2, v8

    .line 611
    .end local v8  # "n":I
    .end local v10  # "b":Ljava/lang/String;
    :cond_1d2
    iget-object v8, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-static {v8, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v8

    return-object v8
.end method

.method public final applyMinhasCartas(Ljava/lang/String;)Lkotlin/Pair;
    .registers 25
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "xml"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 756
    const-string v1, "<DataElem name=\"OwnedCards\" type=\"array\">"

    .line 757
    .local v1, "startTag":Ljava/lang/String;
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v6, 0x6

    const/4 v7, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v3, v1

    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v2

    .line 760
    .local v2, "startPos":I
    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v6, -0x1

    .line 763
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    .line 760
    if-ne v2, v6, :cond_3c

    .line 761
    new-instance v6, Lkotlin/text/Regex;

    const-string v8, "<DataElem\\s+name=\"OwnedCards\"\\s+type=\"array\"\\s*/>"

    invoke-direct {v6, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v0

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v6, v8, v5, v4, v3}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 762
    .local v3, "mSc":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_37

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4

    .line 763
    :cond_37
    invoke-static {v0, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4

    .line 767
    .end local v3  # "mSc":Lkotlin/text/MatchResult;
    :cond_3c
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v8

    add-int/2addr v8, v2

    .line 768
    .local v8, "pos":I
    const/4 v9, 0x1

    .line 769
    .local v9, "depth":I
    const/4 v10, -0x1

    .line 770
    .local v10, "endPos":I
    :goto_43
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v11

    if-ge v8, v11, :cond_a6

    if-lez v9, :cond_a6

    .line 771
    move-object v11, v0

    check-cast v11, Ljava/lang/CharSequence;

    const/4 v15, 0x4

    const/16 v16, 0x0

    const-string v12, "<DataElem"

    const/4 v14, 0x0

    move v13, v8

    invoke-static/range {v11 .. v16}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v15

    .line 772
    .local v15, "openM":I
    move-object v11, v0

    check-cast v11, Ljava/lang/CharSequence;

    const/16 v16, 0x4

    const/16 v17, 0x0

    const-string v12, "</DataElem>"

    move v3, v15

    .end local v15  # "openM":I
    .local v3, "openM":I
    move/from16 v15, v16

    move-object/from16 v16, v17

    invoke-static/range {v11 .. v16}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v11

    .line 773
    .local v11, "closeM":I
    if-eq v11, v6, :cond_a6

    .line 774
    if-eq v3, v6, :cond_9b

    if-ge v3, v11, :cond_9b

    .line 775
    move-object/from16 v17, v0

    check-cast v17, Ljava/lang/CharSequence;

    const/16 v21, 0x4

    const/16 v22, 0x0

    const/16 v18, 0x3e

    const/16 v20, 0x0

    move/from16 v19, v3

    invoke-static/range {v17 .. v22}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;CIZILjava/lang/Object;)I

    move-result v12

    .line 776
    .local v12, "endOfTag":I
    if-eq v12, v6, :cond_91

    add-int/lit8 v13, v12, -0x1

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v13

    const/16 v14, 0x2f

    if-eq v13, v14, :cond_91

    add-int/lit8 v9, v9, 0x1

    .line 777
    :cond_91
    if-eq v12, v6, :cond_96

    add-int/lit8 v13, v12, 0x1

    goto :goto_98

    :cond_96
    add-int/lit8 v13, v3, 0x1

    :goto_98
    move v8, v13

    const/4 v3, 0x0

    .end local v12  # "endOfTag":I
    goto :goto_43

    .line 779
    :cond_9b
    add-int/lit8 v9, v9, -0x1

    .line 780
    if-nez v9, :cond_a2

    add-int/lit8 v10, v11, 0xb

    goto :goto_a6

    .line 781
    :cond_a2
    add-int/lit8 v8, v11, 0xb

    const/4 v3, 0x0

    .end local v3  # "openM":I
    .end local v11  # "closeM":I
    goto :goto_43

    .line 784
    :cond_a6
    :goto_a6
    if-ne v10, v6, :cond_ad

    invoke-static {v0, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 786
    :cond_ad
    invoke-virtual {v0, v2, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v6, "substring(...)"

    invoke-static {v3, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 788
    .local v3, "bloco":Ljava/lang/String;
    new-instance v7, Lkotlin/text/Regex;

    const-string v11, "<DataElem name=\"cardId\""

    invoke-direct {v7, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v11, v3

    check-cast v11, Ljava/lang/CharSequence;

    const/4 v12, 0x0

    invoke-static {v7, v11, v5, v4, v12}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v4

    invoke-static {v4}, Lkotlin/sequences/SequencesKt;->count(Lkotlin/sequences/Sequence;)I

    move-result v4

    .line 800
    .local v4, "total":I
    const-string v7, "generatedCount"

    invoke-static {v3, v7}, Lcom/twntool/editor/core/XmlProcessor;->applyMinhasCartas$sub(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 801
    .local v7, "blocoNovo":Ljava/lang/String;
    const-string v11, "inStockCount"

    invoke-static {v7, v11}, Lcom/twntool/editor/core/XmlProcessor;->applyMinhasCartas$sub(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 802
    const-string v11, "maxInStockCount"

    invoke-static {v7, v11}, Lcom/twntool/editor/core/XmlProcessor;->applyMinhasCartas$sub(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 804
    invoke-virtual {v0, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-static {v5, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v5

    return-object v5
.end method

.method public final applyTodasCartas(Ljava/lang/String;)Lkotlin/Pair;
    .registers 32
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "xml"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 676
    const-string v1, "<DataElem name=\"OwnedCards\" type=\"array\">"

    .line 677
    .local v1, "startTag":Ljava/lang/String;
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v6, 0x6

    const/4 v7, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v3, v1

    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v2

    .line 678
    .local v2, "startPos":I
    const/4 v3, 0x0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v5, -0x1

    if-ne v2, v5, :cond_22

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 681
    :cond_22
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v6

    add-int/2addr v6, v2

    .line 682
    .local v6, "pos":I
    const/4 v7, 0x1

    .line 683
    .local v7, "depth":I
    const/4 v8, -0x1

    .line 684
    .local v8, "endPos":I
    :goto_29
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v9

    if-ge v6, v9, :cond_83

    if-lez v7, :cond_83

    .line 685
    move-object v9, v0

    check-cast v9, Ljava/lang/CharSequence;

    const/4 v13, 0x4

    const/4 v14, 0x0

    const-string v10, "<DataElem"

    const/4 v12, 0x0

    move v11, v6

    invoke-static/range {v9 .. v14}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v15

    .line 686
    .local v15, "openM":I
    move-object v9, v0

    check-cast v9, Ljava/lang/CharSequence;

    const-string v10, "</DataElem>"

    invoke-static/range {v9 .. v14}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v9

    .line 687
    .local v9, "closeM":I
    if-eq v9, v5, :cond_82

    .line 688
    if-eq v15, v5, :cond_77

    if-ge v15, v9, :cond_77

    .line 689
    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    const/16 v19, 0x4

    const/16 v20, 0x0

    const/16 v16, 0x3e

    const/16 v18, 0x0

    move v11, v15

    .end local v15  # "openM":I
    .local v11, "openM":I
    move-object v15, v10

    move/from16 v17, v11

    invoke-static/range {v15 .. v20}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;CIZILjava/lang/Object;)I

    move-result v10

    .line 690
    .local v10, "endOfTag":I
    if-eq v10, v5, :cond_6e

    add-int/lit8 v12, v10, -0x1

    invoke-virtual {v0, v12}, Ljava/lang/String;->charAt(I)C

    move-result v12

    const/16 v13, 0x2f

    if-eq v12, v13, :cond_6e

    add-int/lit8 v7, v7, 0x1

    .line 691
    :cond_6e
    if-eq v10, v5, :cond_73

    add-int/lit8 v12, v10, 0x1

    goto :goto_75

    :cond_73
    add-int/lit8 v12, v11, 0x1

    :goto_75
    move v6, v12

    .end local v10  # "endOfTag":I
    goto :goto_29

    .line 688
    .end local v11  # "openM":I
    .restart local v15  # "openM":I
    :cond_77
    move v11, v15

    .line 693
    .end local v15  # "openM":I
    .restart local v11  # "openM":I
    add-int/lit8 v7, v7, -0x1

    .line 694
    if-nez v7, :cond_7f

    .line 695
    add-int/lit8 v8, v9, 0xb

    .line 696
    goto :goto_83

    .line 698
    :cond_7f
    add-int/lit8 v6, v9, 0xb

    .end local v9  # "closeM":I
    .end local v11  # "openM":I
    goto :goto_29

    .line 687
    .restart local v9  # "closeM":I
    .restart local v15  # "openM":I
    :cond_82
    move v11, v15

    .line 701
    .end local v9  # "closeM":I
    .end local v15  # "openM":I
    :cond_83
    :goto_83
    if-ne v8, v5, :cond_8a

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 703
    :cond_8a
    invoke-virtual {v0, v2, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "substring(...)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 708
    .local v4, "bloco":Ljava/lang/String;
    const/4 v9, 0x3

    new-array v9, v9, [Ljava/lang/String;

    const-string v10, "generatedCount"

    aput-object v10, v9, v3

    const-string v10, "inStockCount"

    const/4 v11, 0x1

    aput-object v10, v9, v11

    const-string v10, "maxInStockCount"

    const/4 v12, 0x2

    aput-object v10, v9, v12

    invoke-static {v9}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_ac
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_ec

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .line 710
    .local v10, "campo":Ljava/lang/String;
    nop

    .line 709
    new-instance v13, Lkotlin/text/Regex;

    sget-object v14, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v14, v10}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "(<DataElem\\s+name=\""

    invoke-virtual {v15, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v14, "\"\\s+type=\"\\w+\"\\s+value=\")([^\"]*?)(\")"

    invoke-virtual {v11, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v13, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 710
    move-object v11, v4

    check-cast v11, Ljava/lang/CharSequence;

    new-instance v14, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda12;

    invoke-direct {v14}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda12;-><init>()V

    invoke-virtual {v13, v11, v14}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v11

    .line 709
    move-object v4, v11

    const/4 v11, 0x1

    .end local v10  # "campo":Ljava/lang/String;
    goto :goto_ac

    .line 714
    :cond_ec
    new-instance v9, Lkotlin/text/Regex;

    const-string v10, "<DataElem name=\"cardId\" type=\"string\" value=\"([^\"]+)\""

    invoke-direct {v9, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 715
    move-object v10, v4

    check-cast v10, Ljava/lang/CharSequence;

    const/4 v11, 0x0

    invoke-static {v9, v10, v3, v12, v11}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v9

    new-instance v10, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda13;

    invoke-direct {v10}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda13;-><init>()V

    invoke-static {v9, v10}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v9

    invoke-static {v9}, Lkotlin/sequences/SequencesKt;->toMutableSet(Lkotlin/sequences/Sequence;)Ljava/util/Set;

    move-result-object v9

    .line 714
    nop

    .line 716
    .local v9, "existentes":Ljava/util/Set;
    const/16 v10, 0x95

    invoke-static {v10}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasCartas$cardId(I)Ljava/lang/String;

    move-result-object v10

    .line 717
    .local v10, "CARTA_RESERVADA":Ljava/lang/String;
    new-instance v11, Lkotlin/ranges/IntRange;

    const/16 v12, 0x96

    const/4 v13, 0x1

    invoke-direct {v11, v13, v12}, Lkotlin/ranges/IntRange;-><init>(II)V

    check-cast v11, Ljava/lang/Iterable;

    .local v11, "$this$map$iv":Ljava/lang/Iterable;
    const/4 v12, 0x0

    .line 1560
    .local v12, "$i$f$map":I
    new-instance v13, Ljava/util/ArrayList;

    const/16 v14, 0xa

    invoke-static {v11, v14}, Lkotlin/collections/CollectionsKt;->collectionSizeOrDefault(Ljava/lang/Iterable;I)I

    move-result v14

    invoke-direct {v13, v14}, Ljava/util/ArrayList;-><init>(I)V

    check-cast v13, Ljava/util/Collection;

    .local v13, "destination$iv$iv":Ljava/util/Collection;
    move-object v14, v11

    .local v14, "$this$mapTo$iv$iv":Ljava/lang/Iterable;
    const/4 v15, 0x0

    .line 1561
    .local v15, "$i$f$mapTo":I
    invoke-interface {v14}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v16

    :goto_12d
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    move-result v17

    if-eqz v17, :cond_148

    move-object/from16 v17, v16

    check-cast v17, Lkotlin/collections/IntIterator;

    invoke-virtual/range {v17 .. v17}, Lkotlin/collections/IntIterator;->nextInt()I

    move-result v17

    .line 1562
    .local v17, "item$iv$iv":I
    move/from16 v18, v17

    .local v18, "it":I
    const/16 v19, 0x0

    .line 717
    .local v19, "$i$a$-map-XmlProcessor$applyTodasCartas$todosIds$1":I
    invoke-static/range {v18 .. v18}, Lcom/twntool/editor/core/XmlProcessor;->applyTodasCartas$cardId(I)Ljava/lang/String;

    move-result-object v3

    .line 1562
    .end local v18  # "it":I
    .end local v19  # "$i$a$-map-XmlProcessor$applyTodasCartas$todosIds$1":I
    invoke-interface {v13, v3}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    const/4 v3, 0x0

    goto :goto_12d

    .line 1563
    .end local v17  # "item$iv$iv":I
    :cond_148
    nop

    .end local v13  # "destination$iv$iv":Ljava/util/Collection;
    .end local v14  # "$this$mapTo$iv$iv":Ljava/lang/Iterable;
    .end local v15  # "$i$f$mapTo":I
    move-object v3, v13

    check-cast v3, Ljava/util/List;

    .line 1560
    nop

    .end local v11  # "$this$map$iv":Ljava/lang/Iterable;
    .end local v12  # "$i$f$map":I
    check-cast v3, Ljava/lang/Iterable;

    .line 717
    invoke-static {v3}, Lkotlin/collections/CollectionsKt;->toMutableSet(Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v3

    move-object v11, v3

    .line 1522
    .local v11, "$this$applyTodasCartas_u24lambda_u2434":Ljava/util/Set;
    const/4 v12, 0x0

    .line 717
    .local v12, "$i$a$-apply-XmlProcessor$applyTodasCartas$todosIds$2":I
    invoke-interface {v11, v10}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 720
    .end local v11  # "$this$applyTodasCartas_u24lambda_u2434":Ljava/util/Set;
    .end local v12  # "$i$a$-apply-XmlProcessor$applyTodasCartas$todosIds$2":I
    .local v3, "todosIds":Ljava/util/Set;
    invoke-interface {v9, v10}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_192

    .line 726
    nop

    .line 721
    new-instance v11, Lkotlin/text/Regex;

    .line 723
    sget-object v12, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v12, v10}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "\\s*<DataElem\\s+type=\"dataStore\">\\s*<DataElem\\s+name=\"cardId\"\\s+type=\"string\"\\s+value=\""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, "\"/>.*?</DataElem>\\s*"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    .line 725
    sget-object v13, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 721
    invoke-direct {v11, v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 726
    move-object v12, v4

    check-cast v12, Ljava/lang/CharSequence;

    const-string v13, "\n"

    invoke-virtual {v11, v12, v13}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 721
    move-object v4, v11

    .line 727
    invoke-interface {v9, v10}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 730
    :cond_192
    move-object v11, v9

    check-cast v11, Ljava/lang/Iterable;

    invoke-static {v3, v11}, Lkotlin/collections/SetsKt;->minus(Ljava/util/Set;Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v11

    check-cast v11, Ljava/lang/Iterable;

    .local v11, "$this$sortedBy$iv":Ljava/lang/Iterable;
    const/4 v12, 0x0

    .line 1564
    .local v12, "$i$f$sortedBy":I
    new-instance v13, Lcom/twntool/editor/core/XmlProcessor$applyTodasCartas$$inlined$sortedBy$1;

    invoke-direct {v13}, Lcom/twntool/editor/core/XmlProcessor$applyTodasCartas$$inlined$sortedBy$1;-><init>()V

    check-cast v13, Ljava/util/Comparator;

    invoke-static {v11, v13}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v11

    .line 730
    .end local v11  # "$this$sortedBy$iv":Ljava/lang/Iterable;
    .end local v12  # "$i$f$sortedBy":I
    nop

    .line 731
    .local v11, "faltantes":Ljava/util/List;
    move-object/from16 v21, v11

    check-cast v21, Ljava/lang/Iterable;

    const-string v12, ""

    move-object/from16 v22, v12

    check-cast v22, Ljava/lang/CharSequence;

    new-instance v27, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda14;

    invoke-direct/range {v27 .. v27}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda14;-><init>()V

    const/16 v28, 0x1e

    const/16 v29, 0x0

    const/16 v23, 0x0

    const/16 v24, 0x0

    const/16 v25, 0x0

    const/16 v26, 0x0

    invoke-static/range {v21 .. v29}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v12

    .line 742
    .local v12, "novas":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v13

    add-int/lit8 v13, v13, -0xb

    const/4 v14, 0x0

    invoke-virtual {v4, v14, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "          </DataElem>"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 744
    invoke-interface {v9}, Ljava/util/Set;->size()I

    move-result v13

    invoke-interface {v11}, Ljava/util/List;->size()I

    move-result v14

    add-int/2addr v13, v14

    .line 745
    .local v13, "total":I
    const/4 v14, 0x0

    invoke-virtual {v0, v14, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v5, v14}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v5

    return-object v5
.end method

.method public final applyTodasVantagens(Ljava/lang/String;Ljava/util/Set;)Lkotlin/Pair;
    .registers 37
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "selecionados"  # Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const-string v2, "xml"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 827
    sget-object v2, Lcom/twntool/editor/data/PortedData;->INSTANCE:Lcom/twntool/editor/data/PortedData;

    invoke-virtual {v2}, Lcom/twntool/editor/data/PortedData;->getVANTAGENS_DEFS()Ljava/util/List;

    move-result-object v2

    .line 828
    .local v2, "BOOST_DEFS":Ljava/util/List;
    if-nez v1, :cond_13

    move-object v5, v2

    goto :goto_44

    .line 829
    :cond_13
    move-object v3, v2

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 1565
    .local v4, "$i$f$filter":I
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    check-cast v5, Ljava/util/Collection;

    .local v5, "destination$iv$iv":Ljava/util/Collection;
    move-object v6, v3

    .local v6, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 1566
    .local v7, "$i$f$filterTo":I
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_24
    :goto_24
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_40

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    .local v9, "element$iv$iv":Ljava/lang/Object;
    move-object v10, v9

    check-cast v10, Lkotlin/Pair;

    .local v10, "it":Lkotlin/Pair;
    const/4 v11, 0x0

    .line 829
    .local v11, "$i$a$-filter-XmlProcessor$applyTodasVantagens$ativas$1":I
    invoke-virtual {v10}, Lkotlin/Pair;->getFirst()Ljava/lang/Object;

    move-result-object v12

    invoke-interface {v1, v12}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v10

    .line 1566
    .end local v10  # "it":Lkotlin/Pair;
    .end local v11  # "$i$a$-filter-XmlProcessor$applyTodasVantagens$ativas$1":I
    if-eqz v10, :cond_24

    invoke-interface {v5, v9}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_24

    .line 1567
    .end local v9  # "element$iv$iv":Ljava/lang/Object;
    :cond_40
    nop

    .end local v5  # "destination$iv$iv":Ljava/util/Collection;
    .end local v6  # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v7  # "$i$f$filterTo":I
    check-cast v5, Ljava/util/List;

    .line 1565
    nop

    .line 828
    .end local v3  # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v4  # "$i$f$filter":I
    :goto_44
    move-object v3, v5

    .line 830
    .local v3, "ativas":Ljava/util/List;
    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v4

    const/4 v5, 0x0

    if-eqz v4, :cond_55

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4

    .line 832
    :cond_55
    new-instance v4, Lkotlin/text/Regex;

    const-string v6, "<SeasonTicket\\b"

    invoke-direct {v4, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v6, v0

    check-cast v6, Ljava/lang/CharSequence;

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v4, v6, v5, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    if-nez v4, :cond_70

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4

    .line 833
    .local v4, "seasonStart":Lkotlin/text/MatchResult;
    :cond_70
    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    .line 834
    .local v6, "sStart":I
    move-object v9, v0

    check-cast v9, Ljava/lang/CharSequence;

    const/4 v13, 0x4

    const/4 v14, 0x0

    const-string v10, "</SeasonTicket>"

    const/4 v12, 0x0

    move v11, v6

    invoke-static/range {v9 .. v14}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v9

    .line 835
    .local v9, "endIdx":I
    const/4 v10, -0x1

    if-ne v9, v10, :cond_91

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    invoke-static {v0, v5}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v5

    return-object v5

    .line 836
    :cond_91
    add-int/lit8 v11, v9, 0xf

    .line 837
    .local v11, "blockEnd":I
    invoke-virtual {v0, v6, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v12

    const-string v13, "substring(...)"

    invoke-static {v12, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 840
    .local v12, "seasonBlock":Ljava/lang/String;
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    check-cast v14, Ljava/util/List;

    .line 841
    .local v14, "varsParaCriar":Ljava/util/List;
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_a7
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_12c

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lkotlin/Pair;

    invoke-virtual/range {v16 .. v16}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v17

    move-object/from16 v10, v17

    check-cast v10, Ljava/lang/String;

    .local v10, "name":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v5, v16

    check-cast v5, Ljava/lang/String;

    .line 842
    .local v5, "value":Ljava/lang/String;
    new-instance v7, Lkotlin/text/Regex;

    sget-object v8, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v8, v10}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v20, v2

    .end local v2  # "BOOST_DEFS":Ljava/util/List;
    .local v20, "BOOST_DEFS":Ljava/util/List;
    const-string v2, "<Var\\s+name=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"[^/]*/>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v7, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, v7

    .line 843
    .local v1, "pat":Lkotlin/text/Regex;
    move-object v2, v12

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_122

    .line 844
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "<Var name=\""

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v7, "\" v=\""

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v7, "\" t=\"i\"/>"

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v14, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v1, p2

    move-object/from16 v2, v20

    const/4 v5, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    const/4 v10, -0x1

    .end local v1  # "pat":Lkotlin/text/Regex;
    goto :goto_a7

    .line 843
    .restart local v1  # "pat":Lkotlin/text/Regex;
    :cond_122
    move-object/from16 v1, p2

    move-object/from16 v2, v20

    const/4 v5, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    const/4 v10, -0x1

    goto/16 :goto_a7

    .line 846
    .end local v1  # "pat":Lkotlin/text/Regex;
    .end local v5  # "value":Ljava/lang/String;
    .end local v10  # "name":Ljava/lang/String;
    .end local v20  # "BOOST_DEFS":Ljava/util/List;
    .restart local v2  # "BOOST_DEFS":Ljava/util/List;
    :cond_12c
    move-object/from16 v20, v2

    .end local v2  # "BOOST_DEFS":Ljava/util/List;
    .restart local v20  # "BOOST_DEFS":Ljava/util/List;
    move-object v1, v14

    check-cast v1, Ljava/util/Collection;

    invoke-interface {v1}, Ljava/util/Collection;->isEmpty()Z

    move-result v1

    const/4 v2, 0x1

    xor-int/2addr v1, v2

    if-eqz v1, :cond_1de

    .line 847
    new-instance v1, Lkotlin/text/Regex;

    const-string v5, "<Vars\\s*/>"

    invoke-direct {v1, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v7, v12

    check-cast v7, Ljava/lang/CharSequence;

    invoke-virtual {v1, v7}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v1

    const-string v7, "quoteReplacement(...)"

    if-eqz v1, :cond_197

    .line 848
    move-object/from16 v21, v14

    check-cast v21, Ljava/lang/Iterable;

    const-string v1, "\n"

    move-object/from16 v22, v1

    check-cast v22, Ljava/lang/CharSequence;

    new-instance v27, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda21;

    invoke-direct/range {v27 .. v27}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda21;-><init>()V

    const/16 v28, 0x1e

    const/16 v29, 0x0

    const/16 v23, 0x0

    const/16 v24, 0x0

    const/16 v25, 0x0

    const/16 v26, 0x0

    invoke-static/range {v21 .. v29}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "\n      <Vars>\n"

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v8, "\n      </Vars>"

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 849
    .local v1, "insert":Ljava/lang/String;
    new-instance v8, Lkotlin/text/Regex;

    invoke-direct {v8, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v5, v12

    check-cast v5, Ljava/lang/CharSequence;

    .line 850
    invoke-static {v1}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 849
    invoke-virtual {v8, v5, v10}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .end local v1  # "insert":Ljava/lang/String;
    goto :goto_1de

    .line 852
    :cond_197
    move-object/from16 v21, v14

    check-cast v21, Ljava/lang/Iterable;

    const-string v1, ""

    move-object/from16 v22, v1

    check-cast v22, Ljava/lang/CharSequence;

    new-instance v27, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda22;

    invoke-direct/range {v27 .. v27}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda22;-><init>()V

    const/16 v28, 0x1e

    const/16 v29, 0x0

    const/16 v23, 0x0

    const/16 v24, 0x0

    const/16 v25, 0x0

    const/16 v26, 0x0

    invoke-static/range {v21 .. v29}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 853
    .local v1, "insertStr":Ljava/lang/String;
    new-instance v5, Lkotlin/text/Regex;

    const-string v8, "(</Vars>)"

    invoke-direct {v5, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v12

    check-cast v8, Ljava/lang/CharSequence;

    .line 854
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v15, "</Vars>"

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 853
    invoke-virtual {v5, v8, v10}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 859
    .end local v1  # "insertStr":Ljava/lang/String;
    :cond_1de
    :goto_1de
    const/4 v1, 0x0

    .line 860
    .local v1, "stagesAdded":I
    new-instance v5, Lkotlin/text/Regex;

    const-string v7, "<PremiumRoad>"

    invoke-direct {v5, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v7, v12

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v8, 0x0

    const/4 v10, 0x2

    const/4 v15, 0x0

    invoke-static {v5, v7, v15, v10, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 861
    .local v5, "premStart":Lkotlin/text/MatchResult;
    if-eqz v5, :cond_335

    .line 862
    move-object/from16 v21, v12

    check-cast v21, Ljava/lang/CharSequence;

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v23

    const/16 v25, 0x4

    const/16 v26, 0x0

    const-string v22, "</PremiumRoad>"

    const/16 v24, 0x0

    invoke-static/range {v21 .. v26}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v7

    .line 863
    .local v7, "premEndRel":I
    const/4 v8, -0x1

    if-eq v7, v8, :cond_328

    .line 864
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    .line 865
    .local v8, "pStart":I
    add-int/lit8 v10, v7, 0xe

    .line 866
    .local v10, "pEnd":I
    invoke-virtual {v12, v8, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 868
    .local v15, "premiumBlock":Ljava/lang/String;
    sget-object v18, Lcom/twntool/editor/data/PortedData;->INSTANCE:Lcom/twntool/editor/data/PortedData;

    invoke-virtual/range {v18 .. v18}, Lcom/twntool/editor/data/PortedData;->getVANTAGENS_ALWAYS_STAGES()Ljava/util/List;

    move-result-object v18

    check-cast v18, Ljava/util/Collection;

    invoke-static/range {v18 .. v18}, Lkotlin/collections/CollectionsKt;->toMutableList(Ljava/util/Collection;)Ljava/util/List;

    move-result-object v2

    .line 869
    .local v2, "stagesToMark":Ljava/util/List;
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v18

    :goto_22e
    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->hasNext()Z

    move-result v22

    if-eqz v22, :cond_263

    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v22

    check-cast v22, Lkotlin/Pair;

    invoke-virtual/range {v22 .. v22}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v22

    move/from16 v23, v1

    .end local v1  # "stagesAdded":I
    .local v23, "stagesAdded":I
    move-object/from16 v1, v22

    check-cast v1, Ljava/lang/String;

    .line 870
    .local v1, "name":Ljava/lang/String;
    sget-object v22, Lcom/twntool/editor/data/PortedData;->INSTANCE:Lcom/twntool/editor/data/PortedData;

    move-object/from16 v24, v3

    .end local v3  # "ativas":Ljava/util/List;
    .local v24, "ativas":Ljava/util/List;
    invoke-virtual/range {v22 .. v22}, Lcom/twntool/editor/data/PortedData;->getVANTAGENS_STAGE_SCORE()Ljava/util/Map;

    move-result-object v3

    invoke-interface {v3, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    if-eqz v3, :cond_25e

    .line 1522
    .local v3, "it":Ljava/lang/String;
    const/16 v22, 0x0

    .line 870
    .local v22, "$i$a$-let-XmlProcessor$applyTodasVantagens$1":I
    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move/from16 v1, v23

    move-object/from16 v3, v24

    .end local v3  # "it":Ljava/lang/String;
    .end local v22  # "$i$a$-let-XmlProcessor$applyTodasVantagens$1":I
    goto :goto_22e

    :cond_25e
    move/from16 v1, v23

    move-object/from16 v3, v24

    .end local v1  # "name":Ljava/lang/String;
    goto :goto_22e

    .line 872
    .end local v23  # "stagesAdded":I
    .end local v24  # "ativas":Ljava/util/List;
    .local v1, "stagesAdded":I
    .local v3, "ativas":Ljava/util/List;
    :cond_263
    move/from16 v23, v1

    move-object/from16 v24, v3

    .end local v1  # "stagesAdded":I
    .end local v3  # "ativas":Ljava/util/List;
    .restart local v23  # "stagesAdded":I
    .restart local v24  # "ativas":Ljava/util/List;
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_26b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2f2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 873
    .local v3, "score":Ljava/lang/String;
    move-object/from16 v18, v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v22, v2

    .end local v2  # "stagesToMark":Ljava/util/List;
    .local v22, "stagesToMark":Ljava/util/List;
    const-string v2, "<Stage score=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v31, v4

    .end local v4  # "seasonStart":Lkotlin/text/MatchResult;
    .local v31, "seasonStart":Lkotlin/text/MatchResult;
    const-string v4, "\">"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 874
    .local v1, "oldTag":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\" rewardGiven=\"1\">"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 875
    .local v2, "newTag":Ljava/lang/String;
    move-object v4, v15

    check-cast v4, Ljava/lang/CharSequence;

    move-object/from16 v32, v3

    .end local v3  # "score":Ljava/lang/String;
    .local v32, "score":Ljava/lang/String;
    move-object v3, v1

    check-cast v3, Ljava/lang/CharSequence;

    move-object/from16 v33, v5

    move/from16 v16, v7

    move/from16 v19, v9

    const/4 v5, 0x0

    const/4 v7, 0x2

    const/4 v9, 0x0

    .end local v5  # "premStart":Lkotlin/text/MatchResult;
    .end local v7  # "premEndRel":I
    .end local v9  # "endIdx":I
    .local v16, "premEndRel":I
    .local v19, "endIdx":I
    .local v33, "premStart":Lkotlin/text/MatchResult;
    invoke-static {v4, v3, v9, v7, v5}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2e4

    .line 876
    const/16 v29, 0x4

    const/16 v30, 0x0

    const/16 v28, 0x0

    move-object/from16 v25, v15

    move-object/from16 v26, v1

    move-object/from16 v27, v2

    invoke-static/range {v25 .. v30}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v15

    .line 877
    nop

    .end local v1  # "oldTag":Ljava/lang/String;
    .end local v2  # "newTag":Ljava/lang/String;
    .end local v32  # "score":Ljava/lang/String;
    add-int/lit8 v23, v23, 0x1

    move/from16 v7, v16

    move-object/from16 v1, v18

    move/from16 v9, v19

    move-object/from16 v2, v22

    move-object/from16 v4, v31

    move-object/from16 v5, v33

    goto :goto_26b

    .line 875
    .restart local v1  # "oldTag":Ljava/lang/String;
    .restart local v2  # "newTag":Ljava/lang/String;
    .restart local v32  # "score":Ljava/lang/String;
    :cond_2e4
    move/from16 v7, v16

    move-object/from16 v1, v18

    move/from16 v9, v19

    move-object/from16 v2, v22

    move-object/from16 v4, v31

    move-object/from16 v5, v33

    goto/16 :goto_26b

    .line 880
    .end local v1  # "oldTag":Ljava/lang/String;
    .end local v16  # "premEndRel":I
    .end local v19  # "endIdx":I
    .end local v22  # "stagesToMark":Ljava/util/List;
    .end local v31  # "seasonStart":Lkotlin/text/MatchResult;
    .end local v32  # "score":Ljava/lang/String;
    .end local v33  # "premStart":Lkotlin/text/MatchResult;
    .local v2, "stagesToMark":Ljava/util/List;
    .restart local v4  # "seasonStart":Lkotlin/text/MatchResult;
    .restart local v5  # "premStart":Lkotlin/text/MatchResult;
    .restart local v7  # "premEndRel":I
    .restart local v9  # "endIdx":I
    :cond_2f2
    move-object/from16 v22, v2

    move-object/from16 v31, v4

    move-object/from16 v33, v5

    move/from16 v16, v7

    move/from16 v19, v9

    .end local v2  # "stagesToMark":Ljava/util/List;
    .end local v4  # "seasonStart":Lkotlin/text/MatchResult;
    .end local v5  # "premStart":Lkotlin/text/MatchResult;
    .end local v7  # "premEndRel":I
    .end local v9  # "endIdx":I
    .restart local v16  # "premEndRel":I
    .restart local v19  # "endIdx":I
    .restart local v22  # "stagesToMark":Ljava/util/List;
    .restart local v31  # "seasonStart":Lkotlin/text/MatchResult;
    .restart local v33  # "premStart":Lkotlin/text/MatchResult;
    if-lez v23, :cond_325

    .line 881
    const/4 v1, 0x0

    invoke-virtual {v12, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v12, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    move/from16 v1, v23

    goto :goto_341

    .line 880
    :cond_325
    move/from16 v1, v23

    goto :goto_341

    .line 863
    .end local v8  # "pStart":I
    .end local v10  # "pEnd":I
    .end local v15  # "premiumBlock":Ljava/lang/String;
    .end local v16  # "premEndRel":I
    .end local v19  # "endIdx":I
    .end local v22  # "stagesToMark":Ljava/util/List;
    .end local v23  # "stagesAdded":I
    .end local v24  # "ativas":Ljava/util/List;
    .end local v31  # "seasonStart":Lkotlin/text/MatchResult;
    .end local v33  # "premStart":Lkotlin/text/MatchResult;
    .local v1, "stagesAdded":I
    .local v3, "ativas":Ljava/util/List;
    .restart local v4  # "seasonStart":Lkotlin/text/MatchResult;
    .restart local v5  # "premStart":Lkotlin/text/MatchResult;
    .restart local v7  # "premEndRel":I
    .restart local v9  # "endIdx":I
    :cond_328
    move/from16 v23, v1

    move-object/from16 v24, v3

    move-object/from16 v31, v4

    move-object/from16 v33, v5

    move/from16 v16, v7

    move/from16 v19, v9

    .end local v1  # "stagesAdded":I
    .end local v3  # "ativas":Ljava/util/List;
    .end local v4  # "seasonStart":Lkotlin/text/MatchResult;
    .end local v5  # "premStart":Lkotlin/text/MatchResult;
    .end local v7  # "premEndRel":I
    .end local v9  # "endIdx":I
    .restart local v16  # "premEndRel":I
    .restart local v19  # "endIdx":I
    .restart local v23  # "stagesAdded":I
    .restart local v24  # "ativas":Ljava/util/List;
    .restart local v31  # "seasonStart":Lkotlin/text/MatchResult;
    .restart local v33  # "premStart":Lkotlin/text/MatchResult;
    goto :goto_33f

    .line 861
    .end local v16  # "premEndRel":I
    .end local v19  # "endIdx":I
    .end local v23  # "stagesAdded":I
    .end local v24  # "ativas":Ljava/util/List;
    .end local v31  # "seasonStart":Lkotlin/text/MatchResult;
    .end local v33  # "premStart":Lkotlin/text/MatchResult;
    .restart local v1  # "stagesAdded":I
    .restart local v3  # "ativas":Ljava/util/List;
    .restart local v4  # "seasonStart":Lkotlin/text/MatchResult;
    .restart local v5  # "premStart":Lkotlin/text/MatchResult;
    .restart local v9  # "endIdx":I
    :cond_335
    move/from16 v23, v1

    move-object/from16 v24, v3

    move-object/from16 v31, v4

    move-object/from16 v33, v5

    move/from16 v19, v9

    .line 885
    .end local v1  # "stagesAdded":I
    .end local v3  # "ativas":Ljava/util/List;
    .end local v4  # "seasonStart":Lkotlin/text/MatchResult;
    .end local v5  # "premStart":Lkotlin/text/MatchResult;
    .end local v9  # "endIdx":I
    .restart local v19  # "endIdx":I
    .restart local v23  # "stagesAdded":I
    .restart local v24  # "ativas":Ljava/util/List;
    .restart local v31  # "seasonStart":Lkotlin/text/MatchResult;
    .restart local v33  # "premStart":Lkotlin/text/MatchResult;
    :goto_33f
    move/from16 v1, v23

    .end local v23  # "stagesAdded":I
    .restart local v1  # "stagesAdded":I
    :goto_341
    invoke-interface {v14}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_353

    if-nez v1, :cond_353

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v0, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 886
    :cond_353
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v2, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2
.end method

.method public final barnCapacityFromUpgrades(I)I
    .registers 5
    .param p1, "upgrades"  # I

    .line 380
    move v0, p1

    .line 381
    .local v0, "n":I
    nop

    .line 382
    const/16 v1, 0x32

    if-gtz v0, :cond_7

    goto :goto_34

    .line 383
    :cond_7
    const/4 v2, 0x3

    if-gt v0, v2, :cond_e

    mul-int/lit8 v2, v0, 0x14

    add-int/2addr v1, v2

    goto :goto_34

    .line 384
    :cond_e
    const/16 v2, 0x27

    if-gt v0, v2, :cond_19

    add-int/lit8 v1, v0, -0x3

    mul-int/lit8 v1, v1, 0x19

    add-int/lit8 v1, v1, 0x6e

    goto :goto_34

    .line 385
    :cond_19
    const/16 v2, 0x3b

    if-gt v0, v2, :cond_23

    add-int/lit8 v2, v0, -0x27

    mul-int/2addr v2, v1

    add-int/lit16 v1, v2, 0x3f2

    goto :goto_34

    .line 386
    :cond_23
    const/16 v1, 0x64

    if-gt v0, v1, :cond_2e

    add-int/lit8 v1, v0, -0x3b

    mul-int/lit8 v1, v1, 0x4b

    add-int/lit16 v1, v1, 0x7da

    goto :goto_34

    .line 387
    :cond_2e
    add-int/lit8 v1, v0, -0x64

    mul-int/lit8 v1, v1, 0x4b

    add-int/lit16 v1, v1, 0x13dd

    .line 381
    :goto_34
    return v1
.end method

.method public final barnUpgradesFromCapacity(I)I
    .registers 6
    .param p1, "capacity"  # I

    .line 393
    move v0, p1

    .line 394
    .local v0, "cap":I
    nop

    .line 395
    const/4 v1, 0x0

    const/16 v2, 0x32

    if-gt v0, v2, :cond_8

    goto :goto_43

    .line 396
    :cond_8
    const/16 v3, 0x6e

    if-gt v0, v3, :cond_15

    add-int/lit8 v2, v0, -0x32

    div-int/lit8 v2, v2, 0x14

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    goto :goto_43

    .line 397
    :cond_15
    const/16 v1, 0x3f2

    if-gt v0, v1, :cond_22

    add-int/lit8 v1, v0, -0x6e

    add-int/lit8 v1, v1, 0x18

    div-int/lit8 v1, v1, 0x19

    add-int/lit8 v1, v1, 0x3

    goto :goto_43

    .line 398
    :cond_22
    const/16 v1, 0x7da

    if-gt v0, v1, :cond_2e

    add-int/lit16 v1, v0, -0x3f2

    add-int/lit8 v1, v1, 0x31

    div-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x27

    goto :goto_43

    .line 399
    :cond_2e
    const/16 v1, 0x13dd

    if-gt v0, v1, :cond_3b

    add-int/lit16 v1, v0, -0x7da

    add-int/lit8 v1, v1, 0x4a

    div-int/lit8 v1, v1, 0x4b

    add-int/lit8 v1, v1, 0x3b

    goto :goto_43

    .line 400
    :cond_3b
    add-int/lit16 v1, v0, -0x13dd

    add-int/lit8 v1, v1, 0x4a

    div-int/lit8 v1, v1, 0x4b

    add-int/lit8 v1, v1, 0x64

    .line 394
    :goto_43
    return v1
.end method

.method public final findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 11
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "name"  # Ljava/lang/String;

    .line 25
    nop

    .line 26
    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "name"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    sget-object v0, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v0, p2}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 25
    .local v0, "esc":Ljava/lang/String;
    new-instance v1, Lkotlin/text/Regex;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "<Var[^>]+name=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\"[^>]+v=\"([^\"]*)\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-static {v1, v2, v3, v4, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    const/4 v2, 0x1

    if-eqz v1, :cond_48

    .line 1522
    .local v1, "it":Lkotlin/text/MatchResult;
    const/4 v3, 0x0

    .line 25
    .local v3, "$i$a$-let-XmlProcessor$findValue$1":I
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    return-object v2

    .line 26
    .end local v1  # "it":Lkotlin/text/MatchResult;
    .end local v3  # "$i$a$-let-XmlProcessor$findValue$1":I
    :cond_48
    new-instance v1, Lkotlin/text/Regex;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "<Var[^>]+v=\"([^\"]*)\"[^>]+name=\""

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\""

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v1, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v6, p1

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v1, v6, v3, v4, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    if-eqz v1, :cond_7b

    .line 1522
    .restart local v1  # "it":Lkotlin/text/MatchResult;
    const/4 v3, 0x0

    .line 26
    .local v3, "$i$a$-let-XmlProcessor$findValue$2":I
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    return-object v2

    .line 27
    .end local v1  # "it":Lkotlin/text/MatchResult;
    .end local v3  # "$i$a$-let-XmlProcessor$findValue$2":I
    :cond_7b
    return-object v5
.end method

.method public final getBarnCapacity(Ljava/lang/String;)I
    .registers 3
    .param p1, "xml"  # Ljava/lang/String;

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 411
    invoke-virtual {p0, p1}, Lcom/twntool/editor/core/XmlProcessor;->getBarnUpgrades(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/twntool/editor/core/XmlProcessor;->barnCapacityFromUpgrades(I)I

    move-result v0

    return v0
.end method

.method public final getBarnItems(Ljava/lang/String;)Ljava/util/List;
    .registers 11
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lcom/twntool/editor/core/XmlProcessor$BarnItem;",
            ">;"
        }
    .end annotation

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 474
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    .line 475
    .local v0, "items":Ljava/util/List;
    new-instance v1, Ljava/util/LinkedHashSet;

    invoke-direct {v1}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v1, Ljava/util/Set;

    .line 476
    .local v1, "seen":Ljava/util/Set;
    sget-object v2, Lcom/twntool/editor/core/XmlProcessor;->BARN_COUNTER_RX:Lkotlin/text/Regex;

    move-object v3, p1

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x2

    invoke-static {v2, v3, v5, v6, v4}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v2

    invoke-interface {v2}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_23
    :goto_23
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_75

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lkotlin/text/MatchResult;

    .line 477
    .local v3, "m":Lkotlin/text/MatchResult;
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    const/4 v5, 0x1

    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 478
    .local v4, "pid":Ljava/lang/String;
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v5

    if-eqz v5, :cond_23

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    .line 479
    .local v5, "qty":I
    sget-object v7, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v4, v7}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "toLowerCase(...)"

    invoke-static {v7, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 480
    .local v7, "key":Ljava/lang/String;
    sget-object v8, Lcom/twntool/editor/core/XmlProcessor;->BARN_COUNTER_BLACKLIST:Ljava/util/Set;

    invoke-interface {v8, v7}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_23

    .line 481
    invoke-interface {v1, v7}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_23

    .line 482
    invoke-interface {v1, v7}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 483
    if-lez v5, :cond_23

    .line 484
    new-instance v8, Lcom/twntool/editor/core/XmlProcessor$BarnItem;

    invoke-direct {v8, v4, v5}, Lcom/twntool/editor/core/XmlProcessor$BarnItem;-><init>(Ljava/lang/String;I)V

    invoke-interface {v0, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .end local v4  # "pid":Ljava/lang/String;
    .end local v5  # "qty":I
    .end local v7  # "key":Ljava/lang/String;
    goto :goto_23

    .line 486
    .end local v3  # "m":Lkotlin/text/MatchResult;
    :cond_75
    move-object v2, v0

    check-cast v2, Ljava/lang/Iterable;

    new-instance v3, Lcom/twntool/editor/core/XmlProcessor$getBarnItems$$inlined$compareByDescending$1;

    invoke-direct {v3}, Lcom/twntool/editor/core/XmlProcessor$getBarnItems$$inlined$compareByDescending$1;-><init>()V

    check-cast v3, Ljava/util/Comparator;

    new-instance v4, Lcom/twntool/editor/core/XmlProcessor$getBarnItems$$inlined$thenBy$1;

    invoke-direct {v4, v3}, Lcom/twntool/editor/core/XmlProcessor$getBarnItems$$inlined$thenBy$1;-><init>(Ljava/util/Comparator;)V

    check-cast v4, Ljava/util/Comparator;

    invoke-static {v2, v4}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v2

    return-object v2
.end method

.method public final getBarnUpgrades(Ljava/lang/String;)I
    .registers 3
    .param p1, "xml"  # Ljava/lang/String;

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 406
    const-string v0, "WareHouseCashUpgrade"

    invoke-virtual {p0, p1, v0}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_18

    invoke-static {v0}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_18

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_19

    :cond_18
    const/4 v0, 0x0

    :goto_19
    return v0
.end method

.method public final getM3Quantities(Ljava/lang/String;)Ljava/util/Map;
    .registers 30
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "xml"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1049
    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v1, Ljava/util/Map;

    .line 1055
    .local v1, "result":Ljava/util/Map;
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "<[Gg]lobal\\b[^>]*>(.*?)</[Gg]lobal>"

    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v2, v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    const/4 v5, 0x2

    const/4 v6, 0x0

    invoke-static {v2, v3, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 1056
    .local v2, "globalMatch":Lkotlin/text/MatchResult;
    const/4 v3, 0x1

    if-eqz v2, :cond_2f

    invoke-interface {v2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v7

    invoke-interface {v7, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    goto :goto_6b

    .line 1058
    :cond_2f
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "<Var\\b[^>]*\\bname=\"m3RainbowBall\"[^>]*/>"

    invoke-direct {v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v0

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v7, v8, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 1059
    .local v7, "anchor":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_6a

    .line 1060
    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    add-int/lit16 v8, v8, -0x7d00

    invoke-static {v4, v8}, Ljava/lang/Math;->max(II)I

    move-result v8

    .line 1061
    .local v8, "s":I
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v9

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v10

    add-int/lit16 v10, v10, 0x7d00

    invoke-static {v9, v10}, Ljava/lang/Math;->min(II)I

    move-result v9

    .line 1062
    .local v9, "e":I
    invoke-virtual {v0, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    const-string v11, "substring(...)"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v7, v10

    .end local v8  # "s":I
    .end local v9  # "e":I
    goto :goto_6b

    .line 1063
    :cond_6a
    move-object v7, v0

    .line 1056
    .end local v7  # "anchor":Lkotlin/text/MatchResult;
    :goto_6b
    nop

    .line 1066
    .local v7, "globalWin":Ljava/lang/String;
    sget-object v8, Lcom/twntool/editor/core/XmlProcessor;->M3_VARS:Ljava/util/List;

    invoke-interface {v8}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_72
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    const-string v10, "\"[^>]*\\bv=\"(\\d+)\""

    const-string v11, "<Var\\b[^>]*\\bname=\""

    if-eqz v9, :cond_ce

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 1067
    .local v9, "vname":Ljava/lang/String;
    new-instance v14, Lkotlin/text/Regex;

    sget-object v15, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v15, v9}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v14, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v10, v7

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v14, v10, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    .line 1068
    .local v10, "m":Lkotlin/text/MatchResult;
    if-eqz v10, :cond_c4

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v11

    if-eqz v11, :cond_c4

    invoke-interface {v11, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    if-eqz v11, :cond_c4

    invoke-static {v11}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v11

    if-eqz v11, :cond_c4

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v12

    goto :goto_c6

    :cond_c4
    const-wide/16 v12, 0x0

    :goto_c6
    invoke-static {v12, v13}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v11

    invoke-interface {v1, v9, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_72

    .line 1072
    .end local v9  # "vname":Ljava/lang/String;
    .end local v10  # "m":Lkotlin/text/MatchResult;
    :cond_ce
    sget-object v8, Lcom/twntool/editor/data/PortedData;->INSTANCE:Lcom/twntool/editor/data/PortedData;

    invoke-virtual {v8}, Lcom/twntool/editor/data/PortedData;->getLAB_BOOST_KEYS()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_d8
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_130

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 1073
    .restart local v9  # "vname":Ljava/lang/String;
    new-instance v12, Lkotlin/text/Regex;

    sget-object v13, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v13, v9}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v13, v7

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v12, v13, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v12

    .line 1074
    .local v12, "m":Lkotlin/text/MatchResult;
    if-eqz v12, :cond_126

    invoke-interface {v12}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v13

    if-eqz v13, :cond_126

    invoke-interface {v13, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    if-eqz v13, :cond_126

    invoke-static {v13}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v13

    if-eqz v13, :cond_126

    invoke-virtual {v13}, Ljava/lang/Long;->longValue()J

    move-result-wide v13

    goto :goto_128

    :cond_126
    const-wide/16 v13, 0x0

    :goto_128
    invoke-static {v13, v14}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v13

    invoke-interface {v1, v9, v13}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_d8

    .line 1078
    .end local v9  # "vname":Ljava/lang/String;
    .end local v12  # "m":Lkotlin/text/MatchResult;
    :cond_130
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    const/16 v12, 0x3e8

    int-to-long v12, v12

    div-long/2addr v8, v12

    .line 1079
    .local v8, "nowTs":J
    const-wide/16 v12, 0x0

    .line 1080
    .local v12, "livesDays":J
    new-instance v14, Lkotlin/text/Regex;

    const-string v15, "<Minigames\\b[^>]*>(.*?)</Minigames>"

    sget-object v3, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v14, v15, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v14, v3, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1081
    .local v3, "mgBlock":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_1c9

    .line 1082
    new-instance v14, Lkotlin/text/Regex;

    const-string v15, "<Vars\\b[^>]*>(.*?)</Vars>"

    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v14, v15, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    const/4 v15, 0x1

    invoke-interface {v4, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v15, 0x0

    invoke-static {v14, v4, v15, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 1083
    .local v4, "varsBlock":Lkotlin/text/MatchResult;
    if-eqz v4, :cond_1c3

    .line 1084
    new-instance v14, Lkotlin/text/Regex;

    const-string v5, "<Var\\b[^>]*\\bname=\"Lives_infTime_Match3\"[^>]*\\bv=\"(\\d+)\""

    invoke-direct {v14, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    const/4 v6, 0x1

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    move-object/from16 v22, v2

    const/4 v2, 0x0

    const/4 v6, 0x2

    .end local v2  # "globalMatch":Lkotlin/text/MatchResult;
    .local v22, "globalMatch":Lkotlin/text/MatchResult;
    invoke-static {v14, v5, v15, v6, v2}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 1085
    .local v5, "mLiv":Lkotlin/text/MatchResult;
    if-eqz v5, :cond_19d

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_19d

    const/4 v6, 0x1

    invoke-interface {v2, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    if-eqz v2, :cond_19d

    invoke-static {v2}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v2

    if-eqz v2, :cond_19d

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v14

    goto :goto_19f

    :cond_19d
    const-wide/16 v14, 0x0

    .line 1086
    .local v14, "livesTs":J
    :goto_19f
    cmp-long v2, v14, v8

    if-lez v2, :cond_1bd

    move-object v6, v3

    .end local v3  # "mgBlock":Lkotlin/text/MatchResult;
    .local v6, "mgBlock":Lkotlin/text/MatchResult;
    sub-long v2, v14, v8

    long-to-double v2, v2

    const-wide v18, 0x40f5180000000000L  # 86400.0

    div-double v2, v2, v18

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    move-object/from16 v23, v4

    move-object/from16 v24, v5

    const-wide/16 v4, 0x1

    .end local v4  # "varsBlock":Lkotlin/text/MatchResult;
    .end local v5  # "mLiv":Lkotlin/text/MatchResult;
    .local v23, "varsBlock":Lkotlin/text/MatchResult;
    .local v24, "mLiv":Lkotlin/text/MatchResult;
    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v12

    goto :goto_1cc

    .end local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v23  # "varsBlock":Lkotlin/text/MatchResult;
    .end local v24  # "mLiv":Lkotlin/text/MatchResult;
    .restart local v3  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v4  # "varsBlock":Lkotlin/text/MatchResult;
    .restart local v5  # "mLiv":Lkotlin/text/MatchResult;
    :cond_1bd
    move-object v6, v3

    move-object/from16 v23, v4

    move-object/from16 v24, v5

    .end local v3  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v4  # "varsBlock":Lkotlin/text/MatchResult;
    .end local v5  # "mLiv":Lkotlin/text/MatchResult;
    .restart local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v23  # "varsBlock":Lkotlin/text/MatchResult;
    .restart local v24  # "mLiv":Lkotlin/text/MatchResult;
    goto :goto_1cc

    .line 1083
    .end local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v14  # "livesTs":J
    .end local v22  # "globalMatch":Lkotlin/text/MatchResult;
    .end local v23  # "varsBlock":Lkotlin/text/MatchResult;
    .end local v24  # "mLiv":Lkotlin/text/MatchResult;
    .restart local v2  # "globalMatch":Lkotlin/text/MatchResult;
    .restart local v3  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v4  # "varsBlock":Lkotlin/text/MatchResult;
    :cond_1c3
    move-object/from16 v22, v2

    move-object v6, v3

    move-object/from16 v23, v4

    .end local v2  # "globalMatch":Lkotlin/text/MatchResult;
    .end local v3  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v4  # "varsBlock":Lkotlin/text/MatchResult;
    .restart local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v22  # "globalMatch":Lkotlin/text/MatchResult;
    .restart local v23  # "varsBlock":Lkotlin/text/MatchResult;
    goto :goto_1cc

    .line 1081
    .end local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v22  # "globalMatch":Lkotlin/text/MatchResult;
    .end local v23  # "varsBlock":Lkotlin/text/MatchResult;
    .restart local v2  # "globalMatch":Lkotlin/text/MatchResult;
    .restart local v3  # "mgBlock":Lkotlin/text/MatchResult;
    :cond_1c9
    move-object/from16 v22, v2

    move-object v6, v3

    .line 1086
    .end local v2  # "globalMatch":Lkotlin/text/MatchResult;
    .end local v3  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v22  # "globalMatch":Lkotlin/text/MatchResult;
    :goto_1cc
    invoke-static {v12, v13}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    .line 1089
    const-string v3, "lives_inf_days"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1092
    const-wide/16 v2, 0x0

    .line 1093
    .local v2, "booster2xDays":J
    new-instance v4, Lkotlin/text/Regex;

    const-string v5, "<item\\s+entityType=\"CouponsM3\"\\s+timeEnd=\"(\\d+)\""

    invoke-direct {v4, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v5, v0

    check-cast v5, Ljava/lang/CharSequence;

    move-wide/from16 v23, v2

    const/4 v2, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x2

    .end local v2  # "booster2xDays":J
    .local v23, "booster2xDays":J
    invoke-static {v4, v5, v14, v15, v2}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1094
    .local v3, "mTed":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_206

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_206

    const/4 v4, 0x1

    invoke-interface {v2, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    if-eqz v2, :cond_206

    invoke-static {v2}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v2

    if-eqz v2, :cond_206

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    goto :goto_208

    :cond_206
    const-wide/16 v4, 0x0

    .line 1095
    .local v4, "boosterTs":J
    :goto_208
    cmp-long v2, v4, v8

    if-lez v2, :cond_223

    sub-long v14, v4, v8

    long-to-double v14, v14

    const-wide v18, 0x40f5180000000000L  # 86400.0

    div-double v14, v14, v18

    invoke-static {v14, v15}, Ljava/lang/Math;->round(D)J

    move-result-wide v14

    move-object/from16 v18, v3

    const-wide/16 v2, 0x1

    .end local v3  # "mTed":Lkotlin/text/MatchResult;
    .local v18, "mTed":Lkotlin/text/MatchResult;
    invoke-static {v2, v3, v14, v15}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    .end local v23  # "booster2xDays":J
    .restart local v2  # "booster2xDays":J
    goto :goto_227

    .end local v2  # "booster2xDays":J
    .end local v18  # "mTed":Lkotlin/text/MatchResult;
    .restart local v3  # "mTed":Lkotlin/text/MatchResult;
    .restart local v23  # "booster2xDays":J
    :cond_223
    move-object/from16 v18, v3

    .end local v3  # "mTed":Lkotlin/text/MatchResult;
    .restart local v18  # "mTed":Lkotlin/text/MatchResult;
    move-wide/from16 v2, v23

    .end local v23  # "booster2xDays":J
    .restart local v2  # "booster2xDays":J
    :goto_227
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v14

    .line 1096
    const-string v15, "booster2x_days"

    invoke-interface {v1, v15, v14}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1100
    sget-object v14, Lcom/twntool/editor/core/XmlProcessor;->GEM_BULLION_FIELDS:Ljava/util/List;

    invoke-interface {v14}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_236
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-eqz v15, :cond_2ab

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, [Ljava/lang/String;

    .line 1101
    .local v15, "def":[Ljava/lang/String;
    move-wide/from16 v20, v2

    const/16 v19, 0x0

    .end local v2  # "booster2xDays":J
    .local v20, "booster2xDays":J
    aget-object v2, v15, v19

    move-wide/from16 v23, v4

    const/4 v3, 0x1

    .end local v4  # "boosterTs":J
    .local v2, "key":Ljava/lang/String;
    .local v23, "boosterTs":J
    aget-object v4, v15, v3

    .line 1102
    .local v4, "plainName":Ljava/lang/String;
    new-instance v3, Lkotlin/text/Regex;

    sget-object v5, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v5, v4}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v19, v4

    .end local v4  # "plainName":Ljava/lang/String;
    .local v19, "plainName":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v4, v7

    check-cast v4, Ljava/lang/CharSequence;

    move-object/from16 v25, v6

    move-wide/from16 v26, v8

    const/4 v5, 0x0

    const/4 v6, 0x2

    const/4 v8, 0x0

    .end local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v8  # "nowTs":J
    .local v25, "mgBlock":Lkotlin/text/MatchResult;
    .local v26, "nowTs":J
    invoke-static {v3, v4, v5, v6, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1103
    .local v3, "m":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_299

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    if-eqz v4, :cond_299

    const/4 v5, 0x1

    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    if-eqz v4, :cond_299

    invoke-static {v4}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v4

    if-eqz v4, :cond_299

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    goto :goto_29b

    :cond_299
    const-wide/16 v4, 0x0

    :goto_29b
    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v1, v2, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-wide/from16 v2, v20

    move-wide/from16 v4, v23

    move-object/from16 v6, v25

    move-wide/from16 v8, v26

    goto :goto_236

    .line 1105
    .end local v3  # "m":Lkotlin/text/MatchResult;
    .end local v15  # "def":[Ljava/lang/String;
    .end local v19  # "plainName":Ljava/lang/String;
    .end local v20  # "booster2xDays":J
    .end local v23  # "boosterTs":J
    .end local v25  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v26  # "nowTs":J
    .local v2, "booster2xDays":J
    .local v4, "boosterTs":J
    .restart local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v8  # "nowTs":J
    :cond_2ab
    move-wide/from16 v20, v2

    move-wide/from16 v23, v4

    move-object/from16 v25, v6

    move-wide/from16 v26, v8

    .end local v2  # "booster2xDays":J
    .end local v4  # "boosterTs":J
    .end local v6  # "mgBlock":Lkotlin/text/MatchResult;
    .end local v8  # "nowTs":J
    .restart local v20  # "booster2xDays":J
    .restart local v23  # "boosterTs":J
    .restart local v25  # "mgBlock":Lkotlin/text/MatchResult;
    .restart local v26  # "nowTs":J
    sget-object v2, Lcom/twntool/editor/core/XmlProcessor;->PLAIN_ONLY_FIELDS:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2b9
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_31b

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Ljava/lang/String;

    .line 1106
    .local v3, "def":[Ljava/lang/String;
    const/4 v4, 0x0

    aget-object v5, v3, v4

    const/4 v4, 0x1

    .local v5, "key":Ljava/lang/String;
    aget-object v6, v3, v4

    .line 1107
    .local v6, "plainName":Ljava/lang/String;
    new-instance v4, Lkotlin/text/Regex;

    sget-object v8, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v8, v6}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v4, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v7

    check-cast v8, Ljava/lang/CharSequence;

    const/4 v9, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    invoke-static {v4, v8, v9, v14, v15}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 1108
    .local v4, "m":Lkotlin/text/MatchResult;
    if-eqz v4, :cond_311

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v8

    if-eqz v8, :cond_311

    const/4 v9, 0x1

    invoke-interface {v8, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    if-eqz v8, :cond_311

    invoke-static {v8}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v8

    if-eqz v8, :cond_311

    invoke-virtual {v8}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    goto :goto_313

    :cond_311
    const-wide/16 v8, 0x0

    :goto_313
    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v8

    invoke-interface {v1, v5, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2b9

    .line 1112
    .end local v3  # "def":[Ljava/lang/String;
    .end local v4  # "m":Lkotlin/text/MatchResult;
    .end local v5  # "key":Ljava/lang/String;
    .end local v6  # "plainName":Ljava/lang/String;
    :cond_31b
    new-instance v2, Lkotlin/text/Regex;

    .line 1113
    nop

    .line 1115
    sget-object v3, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1112
    const-string v4, "<DataElem\\s+name=\"CurrencyProvider\"[^>]*>.*?<DataElem\\s+name=\"Amount\"\\s+type=\"int\"\\s+value=\"(\\d+)\""

    invoke-direct {v2, v4, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1116
    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    const/4 v5, 0x2

    const/4 v6, 0x0

    invoke-static {v2, v3, v4, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 1112
    nop

    .line 1117
    .local v2, "cpMatch":Lkotlin/text/MatchResult;
    if-eqz v2, :cond_34c

    invoke-interface {v2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_34c

    const/4 v4, 0x1

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    if-eqz v3, :cond_34c

    invoke-static {v3}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v3

    if-eqz v3, :cond_34c

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    goto :goto_34e

    :cond_34c
    const-wide/16 v3, 0x0

    :goto_34e
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    const-string v4, "currency_provider_amount"

    invoke-interface {v1, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1120
    new-instance v3, Lkotlin/text/Regex;

    .line 1121
    nop

    .line 1124
    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1120
    const-string v5, "<DataElem\\s+name=\"TrainJourney\"\\s+type=\"dataStore\">.*?<DataElem\\s+name=\"CurrencyProvider\"[^>]*>.*?<DataElem\\s+name=\"Amount\"\\s+type=\"int\"\\s+value=\"(\\d+)\""

    invoke-direct {v3, v5, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1125
    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x2

    const/4 v8, 0x0

    invoke-static {v3, v4, v5, v6, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1120
    nop

    .line 1126
    .local v3, "tjMatch":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_38a

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    if-eqz v4, :cond_38a

    const/4 v5, 0x1

    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    if-eqz v4, :cond_38a

    invoke-static {v4}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v4

    if-eqz v4, :cond_38a

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    move-wide/from16 v16, v4

    goto :goto_38c

    :cond_38a
    const-wide/16 v16, 0x0

    :goto_38c
    invoke-static/range {v16 .. v17}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const-string v5, "train_journey_amount"

    invoke-interface {v1, v5, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1128
    return-object v1
.end method

.method public final getM3_VARS()Ljava/util/List;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1008
    sget-object v0, Lcom/twntool/editor/core/XmlProcessor;->M3_VARS:Ljava/util/List;

    return-object v0
.end method

.method public final insertVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 13
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "name"  # Ljava/lang/String;
    .param p3, "value"  # Ljava/lang/String;

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "name"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "value"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "<Var name=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" v=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\"/>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 52
    .local v0, "tag":Ljava/lang/String;
    new-instance v1, Lkotlin/text/Regex;

    const-string v2, "</Global\\s*>"

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v1, v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-static {v1, v2, v3, v4, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 53
    .local v1, "mGlobal":Lkotlin/text/MatchResult;
    const-string v2, "substring(...)"

    if-eqz v1, :cond_7d

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 54
    :cond_7d
    new-instance v6, Lkotlin/text/Regex;

    const-string v7, "</root\\s*>"

    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v6, v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v7, p1

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v6, v7, v3, v4, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 55
    .local v4, "mRoot":Lkotlin/text/MatchResult;
    if-eqz v4, :cond_c3

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {p1, v3, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {p1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 56
    :cond_c3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public final isBarnIntegrityOK(Ljava/lang/String;)Z
    .registers 6
    .param p1, "xml"  # Ljava/lang/String;

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 415
    const-string v0, "WareHouseCashUpgrade"

    invoke-virtual {p0, p1, v0}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_38

    invoke-static {v0}, Lkotlin/text/UStringsKt;->toUIntOrNull(Ljava/lang/String;)Lkotlin/UInt;

    move-result-object v0

    if-eqz v0, :cond_38

    invoke-virtual {v0}, Lkotlin/UInt;->unbox-impl()I

    move-result v0

    .line 416
    .local v0, "whu":I
    const-string v2, "WHUdup"

    invoke-virtual {p0, p1, v2}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_37

    invoke-static {v2}, Lkotlin/text/UStringsKt;->toUIntOrNull(Ljava/lang/String;)Lkotlin/UInt;

    move-result-object v2

    if-eqz v2, :cond_37

    invoke-virtual {v2}, Lkotlin/UInt;->unbox-impl()I

    move-result v2

    .line 417
    .local v2, "dup":I
    const v3, 0x1eadabcc

    xor-int/2addr v3, v0

    invoke-static {v3}, Lkotlin/UInt;->constructor-impl(I)I

    move-result v3

    if-ne v3, v2, :cond_35

    goto :goto_36

    :cond_35
    const/4 v1, 0x0

    :goto_36
    return v1

    .line 416
    .end local v2  # "dup":I
    :cond_37
    return v1

    .line 415
    .end local v0  # "whu":I
    :cond_38
    return v1
.end method

.method public final processMarketSlots(Ljava/lang/String;I)Lkotlin/Pair;
    .registers 16
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "count"  # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I)",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1460
    const/16 v0, 0x270f

    const/4 v1, 0x1

    .line 1468
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    .line 1460
    invoke-static {p2, v1, v0}, Lkotlin/ranges/RangesKt;->coerceIn(III)I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 1462
    .local v0, "c":Ljava/lang/String;
    new-instance v3, Lkotlin/text/Regex;

    .line 1463
    nop

    .line 1464
    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1462
    const-string v5, "(storeId&quot;:&quot;citymarket&quot;(?:(?!&quot;storeId&quot;).){1,2000}?&quot;slotsCount&quot;:)(\\d+)"

    invoke-direct {v3, v5, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1465
    move-object v4, p1

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x2

    const/4 v7, 0x0

    invoke-static {v3, v4, v5, v6, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1462
    nop

    .line 1466
    .local v3, "p1":Lkotlin/text/MatchResult;
    const-string v4, "substring(...)"

    if-eqz v3, :cond_71

    .line 1467
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroups()Lkotlin/text/MatchGroupCollection;

    move-result-object v7

    invoke-interface {v7, v6}, Lkotlin/text/MatchGroupCollection;->get(I)Lkotlin/text/MatchGroup;

    move-result-object v6

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 1468
    .local v6, "g":Lkotlin/text/MatchGroup;
    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {p1, v5, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v7

    add-int/2addr v7, v1

    invoke-virtual {p1, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    return-object v1

    .line 1471
    .end local v6  # "g":Lkotlin/text/MatchGroup;
    :cond_71
    new-instance v8, Lkotlin/text/Regex;

    .line 1472
    nop

    .line 1473
    sget-object v9, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1471
    const-string v10, "(\"storeId\"\\s*:\\s*\"citymarket\"(?:(?!\"storeId\").){1,2000}?\"slotsCount\"\\s*:)\\s*(\\d+)"

    invoke-direct {v8, v10, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1474
    move-object v9, p1

    check-cast v9, Ljava/lang/CharSequence;

    invoke-static {v8, v9, v5, v6, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v8

    .line 1471
    nop

    .line 1475
    .local v8, "p2":Lkotlin/text/MatchResult;
    if-eqz v8, :cond_c9

    .line 1476
    invoke-interface {v8}, Lkotlin/text/MatchResult;->getGroups()Lkotlin/text/MatchGroupCollection;

    move-result-object v7

    invoke-interface {v7, v6}, Lkotlin/text/MatchGroupCollection;->get(I)Lkotlin/text/MatchGroup;

    move-result-object v6

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 1477
    .restart local v6  # "g":Lkotlin/text/MatchGroup;
    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {p1, v5, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v7

    add-int/2addr v7, v1

    invoke-virtual {p1, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    return-object v1

    .line 1480
    .end local v6  # "g":Lkotlin/text/MatchGroup;
    :cond_c9
    new-instance v9, Lkotlin/text/Regex;

    .line 1481
    nop

    .line 1482
    sget-object v10, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1480
    const-string v11, "(&quot;slotsCount&quot;:)(\\d+)(?:(?!&quot;storeId&quot;).){1,2000}?storeId&quot;:&quot;citymarket&quot;"

    invoke-direct {v9, v11, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1483
    move-object v10, p1

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v9, v10, v5, v6, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    .line 1480
    nop

    .line 1484
    .local v9, "p3":Lkotlin/text/MatchResult;
    if-eqz v9, :cond_121

    .line 1485
    invoke-interface {v9}, Lkotlin/text/MatchResult;->getGroups()Lkotlin/text/MatchGroupCollection;

    move-result-object v7

    invoke-interface {v7, v6}, Lkotlin/text/MatchGroupCollection;->get(I)Lkotlin/text/MatchGroup;

    move-result-object v6

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 1486
    .restart local v6  # "g":Lkotlin/text/MatchGroup;
    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {p1, v5, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v7

    add-int/2addr v7, v1

    invoke-virtual {p1, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    return-object v1

    .line 1489
    .end local v6  # "g":Lkotlin/text/MatchGroup;
    :cond_121
    new-instance v10, Lkotlin/text/Regex;

    .line 1490
    nop

    .line 1491
    sget-object v11, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1489
    const-string v12, "(\"slotsCount\"\\s*:)\\s*(\\d+)(?:(?!\"storeId\").){1,2000}?\"storeId\"\\s*:\\s*\"citymarket\""

    invoke-direct {v10, v12, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1492
    move-object v11, p1

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v10, v11, v5, v6, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 1489
    nop

    .line 1493
    .local v7, "p4":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_179

    .line 1494
    invoke-interface {v7}, Lkotlin/text/MatchResult;->getGroups()Lkotlin/text/MatchGroupCollection;

    move-result-object v10

    invoke-interface {v10, v6}, Lkotlin/text/MatchGroupCollection;->get(I)Lkotlin/text/MatchGroup;

    move-result-object v6

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 1495
    .restart local v6  # "g":Lkotlin/text/MatchGroup;
    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    invoke-virtual {p1, v5, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v6}, Lkotlin/text/MatchGroup;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v10

    add-int/2addr v10, v1

    invoke-virtual {p1, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    return-object v1

    .line 1497
    .end local v6  # "g":Lkotlin/text/MatchGroup;
    :cond_179
    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {p1, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    return-object v1
.end method

.method public final processRegata(Ljava/lang/String;I)Lkotlin/Pair;
    .registers 26
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "total"  # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I)",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    move/from16 v1, p2

    const-string v2, "xml"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 62
    new-instance v2, Lkotlin/text/Regex;

    const/4 v3, 0x2

    new-array v4, v3, [Lkotlin/text/RegexOption;

    sget-object v5, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    const/4 v6, 0x0

    .line 63
    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    .line 62
    aput-object v5, v4, v6

    sget-object v5, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    const/4 v8, 0x1

    aput-object v5, v4, v8

    invoke-static {v4}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v4

    const-string v5, "(<Regata\\b.*?</Regata>)"

    invoke-direct {v2, v5, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Ljava/util/Set;)V

    .line 63
    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    invoke-static {v2, v4, v6, v3, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 62
    if-nez v2, :cond_34

    .line 63
    invoke-static {v0, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 65
    .local v2, "mRegata":Lkotlin/text/MatchResult;
    :cond_34
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 66
    .local v4, "original":Ljava/lang/String;
    new-instance v9, Lkotlin/text/Regex;

    const-string v10, "<MyOldTask\\b[^>]*/>"

    invoke-direct {v9, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v10, v4

    check-cast v10, Ljava/lang/CharSequence;

    const-string v11, ""

    invoke-virtual {v9, v10, v11}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 67
    .local v9, "bloco":Ljava/lang/String;
    new-instance v10, Lkotlin/text/Regex;

    const-string v12, "user=\"([^\"]*)\""

    invoke-direct {v10, v12}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v12, v9

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v10, v12, v6, v3, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    if-eqz v10, :cond_6e

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v10

    if-eqz v10, :cond_6e

    invoke-interface {v10, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    if-nez v10, :cond_6d

    goto :goto_6e

    :cond_6d
    move-object v11, v10

    :cond_6e
    :goto_6e
    move-object v10, v11

    .line 69
    .local v10, "userId":Ljava/lang/String;
    const/4 v11, 0x0

    .line 70
    .local v11, "taskId":Ljava/lang/String;
    new-instance v12, Lkotlin/text/Regex;

    const-string v13, "<FreeTask\\b[^>]*id=\"([^\"]*)\""

    invoke-direct {v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v13, v9

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v12, v13, v6, v3, v5}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v12

    invoke-interface {v12}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v12

    :cond_82
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    const-string v14, "match3_"

    if-eqz v13, :cond_a1

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lkotlin/text/MatchResult;

    .line 71
    .local v13, "m":Lkotlin/text/MatchResult;
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v15

    invoke-interface {v15, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 72
    .local v15, "id":Ljava/lang/String;
    invoke-static {v15, v14, v6, v3, v5}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_82

    move-object v11, v15

    .line 74
    .end local v13  # "m":Lkotlin/text/MatchResult;
    .end local v15  # "id":Ljava/lang/String;
    :cond_a1
    if-nez v11, :cond_a8

    invoke-static {v0, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 76
    :cond_a8
    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v11, v14}, Lkotlin/text/StringsKt;->removePrefix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v12

    .line 77
    .local v12, "target":Ljava/lang/String;
    move-object v13, v12

    check-cast v13, Ljava/lang/CharSequence;

    const/16 v17, 0x6

    const/16 v18, 0x0

    const-string v14, "_"

    const/4 v15, 0x0

    const/16 v16, 0x0

    invoke-static/range {v13 .. v18}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v13

    .line 78
    .local v13, "idx":I
    const-string v14, "substring(...)"

    if-lez v13, :cond_ca

    invoke-virtual {v12, v6, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v12, v15

    .line 80
    :cond_ca
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    .line 81
    .local v15, "tarefas":Ljava/lang/StringBuilder;
    const/16 v16, 0x0

    move/from16 v8, v16

    .local v8, "i":I
    :goto_d3
    if-ge v8, v1, :cond_14e

    .line 82
    move-object/from16 v16, v4

    .end local v4  # "original":Ljava/lang/String;
    .local v16, "original":Ljava/lang/String;
    int-to-long v3, v8

    const-wide/16 v19, 0x7080

    mul-long v3, v3, v19

    const-wide/32 v19, 0x692cb050

    add-long v3, v3, v19

    .line 83
    .local v3, "realEnd":J
    nop

    .line 84
    nop

    .line 85
    add-int/lit8 v5, v8, 0x6

    .line 86
    add-int/lit8 v6, v8, 0x2

    .line 87
    move/from16 v21, v13

    .end local v13  # "idx":I
    .local v21, "idx":I
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v22, v2

    .end local v2  # "mRegata":Lkotlin/text/MatchResult;
    .local v22, "mRegata":Lkotlin/text/MatchResult;
    const-string v2, "<MyOldTask id=\""

    invoke-virtual {v13, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v13, "\" type=\"event_order\" eventType=\"Match3\" target=\""

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v13, "\" user=\""

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v13, "\" num=\""

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "\" ver=\"1\" takenCounter=\""

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "\" score=\"135\" realEndTime=\""

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "\"/>"

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 83
    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 89
    add-int/lit8 v2, v1, -0x1

    if-ge v8, v2, :cond_142

    sget-object v2, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 81
    .end local v3  # "realEnd":J
    :cond_142
    add-int/lit8 v8, v8, 0x1

    move-object/from16 v4, v16

    move/from16 v13, v21

    move-object/from16 v2, v22

    const/4 v3, 0x2

    const/4 v5, 0x0

    const/4 v6, 0x0

    goto :goto_d3

    .end local v16  # "original":Ljava/lang/String;
    .end local v21  # "idx":I
    .end local v22  # "mRegata":Lkotlin/text/MatchResult;
    .restart local v2  # "mRegata":Lkotlin/text/MatchResult;
    .restart local v4  # "original":Ljava/lang/String;
    .restart local v13  # "idx":I
    :cond_14e
    move-object/from16 v22, v2

    move-object/from16 v16, v4

    move/from16 v21, v13

    .line 92
    .end local v2  # "mRegata":Lkotlin/text/MatchResult;
    .end local v4  # "original":Ljava/lang/String;
    .end local v8  # "i":I
    .end local v13  # "idx":I
    .restart local v16  # "original":Ljava/lang/String;
    .restart local v21  # "idx":I
    .restart local v22  # "mRegata":Lkotlin/text/MatchResult;
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "<Vars\\b"

    invoke-direct {v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v9

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x2

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static {v2, v3, v5, v4, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    if-nez v2, :cond_16c

    invoke-static {v0, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 93
    .local v2, "mVars":Lkotlin/text/MatchResult;
    :cond_16c
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    .line 94
    .local v3, "pos":I
    invoke-virtual {v9, v5, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v5, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    invoke-virtual {v9, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 95
    .local v4, "blocoNovo":Ljava/lang/String;
    invoke-interface/range {v22 .. v22}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface/range {v22 .. v22}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v6

    const/4 v7, 0x1

    add-int/2addr v6, v7

    invoke-virtual {v0, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 96
    .local v5, "xmlNovo":Ljava/lang/String;
    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-static {v5, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    return-object v6
.end method

.method public final processRegataApk(Ljava/lang/String;)Lkotlin/Pair;
    .registers 33
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "xml"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1368
    nop

    .line 1369
    nop

    .line 1368
    new-instance v1, Lkotlin/text/Regex;

    const-string v2, "<Var\\s+name=\"cityId\"\\s+v=\"([^\"]*)\""

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v1, v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1369
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    .line 1374
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    .line 1369
    const/4 v5, 0x2

    const/4 v6, 0x0

    invoke-static {v1, v2, v3, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    const-string v2, ""

    const/4 v7, 0x1

    .line 1388
    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    .line 1369
    if-eqz v1, :cond_3a

    .line 1368
    nop

    .line 1369
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_3a

    .line 1368
    nop

    .line 1369
    invoke-interface {v1, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1368
    if-eqz v1, :cond_3a

    goto :goto_3b

    .line 1369
    :cond_3a
    move-object v1, v2

    .line 1368
    :goto_3b
    nop

    .line 1372
    .local v1, "cityId":Ljava/lang/String;
    new-instance v9, Lkotlin/text/Regex;

    .line 1373
    new-array v10, v5, [Lkotlin/text/RegexOption;

    sget-object v11, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    aput-object v11, v10, v3

    sget-object v11, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    aput-object v11, v10, v7

    invoke-static {v10}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v10

    .line 1372
    const-string v11, "(<RegataCenter\\b.*?</RegataCenter>)"

    invoke-direct {v9, v11, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Ljava/util/Set;)V

    .line 1373
    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v9, v10, v3, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    .line 1372
    if-nez v9, :cond_5f

    .line 1374
    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 1375
    .local v9, "mCenter":Lkotlin/text/MatchResult;
    :cond_5f
    invoke-interface {v9}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v10

    invoke-interface {v10, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .line 1378
    .local v10, "blocoCenter":Ljava/lang/String;
    new-instance v11, Lkotlin/text/Regex;

    .line 1379
    new-array v12, v5, [Lkotlin/text/RegexOption;

    sget-object v13, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    aput-object v13, v12, v3

    sget-object v13, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    aput-object v13, v12, v7

    invoke-static {v12}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v12

    .line 1378
    const-string v13, "(<Regata\\b.*?</Regata>)"

    invoke-direct {v11, v13, v12}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Ljava/util/Set;)V

    .line 1379
    move-object v12, v10

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v11, v12, v3, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v11

    .line 1378
    if-nez v11, :cond_8c

    .line 1380
    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 1381
    .local v11, "mRegata":Lkotlin/text/MatchResult;
    :cond_8c
    invoke-interface {v11}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v12

    invoke-interface {v12, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .line 1384
    .local v12, "blocoRegata":Ljava/lang/String;
    new-instance v13, Lkotlin/text/Regex;

    const-string v14, "<MyOldTask\\b[^>]*/?>"

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v13, v14, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1385
    move-object v14, v12

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v13, v14, v3, v5, v6}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v13

    invoke-static {v13}, Lkotlin/sequences/SequencesKt;->toList(Lkotlin/sequences/Sequence;)Ljava/util/List;

    move-result-object v13

    .line 1384
    nop

    .line 1386
    .local v13, "oldTasks":Ljava/util/List;
    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v14

    .line 1387
    .local v14, "existing":I
    rsub-int/lit8 v15, v14, 0x64

    invoke-static {v3, v15}, Ljava/lang/Math;->max(II)I

    move-result v15

    .line 1388
    .local v15, "needed":I
    if-nez v15, :cond_bc

    invoke-static {v0, v8}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 1392
    :cond_bc
    new-instance v16, Ljava/util/ArrayList;

    invoke-direct/range {v16 .. v16}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v7, v16

    check-cast v7, Ljava/util/List;

    .line 1393
    .local v7, "templates":Ljava/util/List;
    new-instance v3, Lkotlin/text/Regex;

    const-string v5, "<FreeTask\\b([^>]*)/?>"

    sget-object v6, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v3, v5, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v5, v12

    check-cast v5, Ljava/lang/CharSequence;

    move-object/from16 v18, v8

    move/from16 v17, v14

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v14, 0x2

    .end local v14  # "existing":I
    .local v17, "existing":I
    invoke-static {v3, v5, v6, v14, v8}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v3

    .local v3, "$this$forEach$iv":Lkotlin/sequences/Sequence;
    const/4 v5, 0x0

    .line 1568
    .local v5, "$i$f$forEach":I
    invoke-interface {v3}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_e1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    const-string v14, "substring(...)"

    if-eqz v8, :cond_1e8

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element$iv":Ljava/lang/Object;
    move-object/from16 v19, v8

    check-cast v19, Lkotlin/text/MatchResult;

    .local v19, "m":Lkotlin/text/MatchResult;
    const/16 v20, 0x0

    .line 1394
    .local v20, "$i$a$-forEach-XmlProcessor$processRegataApk$1":I
    move-object/from16 v21, v3

    .end local v3  # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .local v21, "$this$forEach$iv":Lkotlin/sequences/Sequence;
    invoke-interface/range {v19 .. v19}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v3

    move/from16 v22, v5

    const/4 v5, 0x1

    .end local v5  # "$i$f$forEach":I
    .local v22, "$i$f$forEach":I
    invoke-interface {v3, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 1395
    .local v3, "attrs":Ljava/lang/String;
    new-instance v5, Lkotlin/text/Regex;

    move-object/from16 v23, v6

    const-string v6, "id=\"([^\"]*)\""

    invoke-direct {v5, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v6, v3

    check-cast v6, Ljava/lang/CharSequence;

    move-object/from16 v24, v8

    move-object/from16 v25, v9

    move-object/from16 v26, v10

    const/4 v8, 0x0

    const/4 v9, 0x2

    const/4 v10, 0x0

    .end local v8  # "element$iv":Ljava/lang/Object;
    .end local v9  # "mCenter":Lkotlin/text/MatchResult;
    .end local v10  # "blocoCenter":Ljava/lang/String;
    .local v24, "element$iv":Ljava/lang/Object;
    .local v25, "mCenter":Lkotlin/text/MatchResult;
    .local v26, "blocoCenter":Ljava/lang/String;
    invoke-static {v5, v6, v8, v9, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    if-eqz v5, :cond_1d2

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    if-eqz v5, :cond_1d2

    const/4 v6, 0x1

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    if-nez v5, :cond_134

    move-object/from16 v28, v2

    move-object/from16 v30, v3

    move-object/from16 v27, v11

    goto/16 :goto_1d8

    .line 1396
    .local v5, "id":Ljava/lang/String;
    :cond_134
    sget-object v6, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v5, v6}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v6

    const-string v8, "toLowerCase(...)"

    invoke-static {v6, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v8, "match3_"

    move-object/from16 v27, v11

    const/4 v9, 0x0

    const/4 v10, 0x2

    const/4 v11, 0x0

    .end local v11  # "mRegata":Lkotlin/text/MatchResult;
    .local v27, "mRegata":Lkotlin/text/MatchResult;
    invoke-static {v6, v8, v9, v10, v11}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1cd

    .line 1397
    const/4 v6, 0x7

    invoke-virtual {v5, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1398
    .local v6, "rawTarget":Ljava/lang/String;
    new-instance v8, Lkotlin/text/Regex;

    const-string v9, "_\\d+$"

    invoke-direct {v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v9, v6

    check-cast v9, Ljava/lang/CharSequence;

    invoke-virtual {v8, v9, v2}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 1399
    .local v8, "target":Ljava/lang/String;
    move-object v9, v8

    check-cast v9, Ljava/lang/CharSequence;

    invoke-interface {v9}, Ljava/lang/CharSequence;->length()I

    move-result v9

    if-nez v9, :cond_16d

    const/4 v9, 0x1

    goto :goto_16e

    :cond_16d
    const/4 v9, 0x0

    :goto_16e
    if-nez v9, :cond_1c8

    .line 1400
    new-instance v9, Lkotlin/text/Regex;

    const-string v10, "num=\"([^\"]*)\""

    invoke-direct {v9, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v10, v3

    check-cast v10, Ljava/lang/CharSequence;

    move-object/from16 v28, v2

    const/4 v2, 0x0

    const/4 v11, 0x0

    const/4 v14, 0x2

    invoke-static {v9, v10, v11, v14, v2}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    const-string v2, "1"

    if-eqz v9, :cond_196

    invoke-interface {v9}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v9

    if-eqz v9, :cond_196

    const/4 v10, 0x1

    invoke-interface {v9, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    if-nez v9, :cond_197

    :cond_196
    move-object v9, v2

    .line 1401
    .local v9, "num":Ljava/lang/String;
    :cond_197
    new-instance v10, Lkotlin/text/Regex;

    const-string v11, "ver=\"([^\"]*)\""

    invoke-direct {v10, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v11, v3

    check-cast v11, Ljava/lang/CharSequence;

    move-object/from16 v29, v2

    move-object/from16 v30, v3

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v14, 0x0

    .end local v3  # "attrs":Ljava/lang/String;
    .local v30, "attrs":Ljava/lang/String;
    invoke-static {v10, v11, v14, v2, v3}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    if-eqz v10, :cond_1bd

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_1bd

    const/4 v3, 0x1

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    if-nez v2, :cond_1bf

    :cond_1bd
    move-object/from16 v2, v29

    .line 1402
    .local v2, "ver":Ljava/lang/String;
    :cond_1bf
    new-instance v3, Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;

    invoke-direct {v3, v5, v8, v9, v2}, Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v7, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1403
    goto :goto_1d8

    .line 1399
    .end local v2  # "ver":Ljava/lang/String;
    .end local v9  # "num":Ljava/lang/String;
    .end local v30  # "attrs":Ljava/lang/String;
    .restart local v3  # "attrs":Ljava/lang/String;
    :cond_1c8
    move-object/from16 v28, v2

    move-object/from16 v30, v3

    .end local v3  # "attrs":Ljava/lang/String;
    .restart local v30  # "attrs":Ljava/lang/String;
    goto :goto_1d8

    .line 1396
    .end local v6  # "rawTarget":Ljava/lang/String;
    .end local v8  # "target":Ljava/lang/String;
    .end local v30  # "attrs":Ljava/lang/String;
    .restart local v3  # "attrs":Ljava/lang/String;
    :cond_1cd
    move-object/from16 v28, v2

    move-object/from16 v30, v3

    .end local v3  # "attrs":Ljava/lang/String;
    .restart local v30  # "attrs":Ljava/lang/String;
    goto :goto_1d8

    .line 1395
    .end local v5  # "id":Ljava/lang/String;
    .end local v27  # "mRegata":Lkotlin/text/MatchResult;
    .end local v30  # "attrs":Ljava/lang/String;
    .restart local v3  # "attrs":Ljava/lang/String;
    .restart local v11  # "mRegata":Lkotlin/text/MatchResult;
    :cond_1d2
    move-object/from16 v28, v2

    move-object/from16 v30, v3

    move-object/from16 v27, v11

    .line 1568
    .end local v3  # "attrs":Ljava/lang/String;
    .end local v11  # "mRegata":Lkotlin/text/MatchResult;
    .end local v19  # "m":Lkotlin/text/MatchResult;
    .end local v20  # "$i$a$-forEach-XmlProcessor$processRegataApk$1":I
    .restart local v27  # "mRegata":Lkotlin/text/MatchResult;
    :goto_1d8
    move-object/from16 v3, v21

    move/from16 v5, v22

    move-object/from16 v6, v23

    move-object/from16 v9, v25

    move-object/from16 v10, v26

    move-object/from16 v11, v27

    move-object/from16 v2, v28

    .end local v24  # "element$iv":Ljava/lang/Object;
    goto/16 :goto_e1

    .line 1569
    .end local v21  # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v22  # "$i$f$forEach":I
    .end local v25  # "mCenter":Lkotlin/text/MatchResult;
    .end local v26  # "blocoCenter":Ljava/lang/String;
    .end local v27  # "mRegata":Lkotlin/text/MatchResult;
    .local v3, "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .local v5, "$i$f$forEach":I
    .local v9, "mCenter":Lkotlin/text/MatchResult;
    .restart local v10  # "blocoCenter":Ljava/lang/String;
    .restart local v11  # "mRegata":Lkotlin/text/MatchResult;
    :cond_1e8
    move-object/from16 v21, v3

    move/from16 v22, v5

    move-object/from16 v25, v9

    move-object/from16 v26, v10

    move-object/from16 v27, v11

    .line 1404
    .end local v3  # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v5  # "$i$f$forEach":I
    .end local v9  # "mCenter":Lkotlin/text/MatchResult;
    .end local v10  # "blocoCenter":Ljava/lang/String;
    .end local v11  # "mRegata":Lkotlin/text/MatchResult;
    .restart local v25  # "mCenter":Lkotlin/text/MatchResult;
    .restart local v26  # "blocoCenter":Ljava/lang/String;
    .restart local v27  # "mRegata":Lkotlin/text/MatchResult;
    invoke-interface {v7}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1fd

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 1407
    :cond_1fd
    const/4 v2, 0x0

    .line 1408
    .local v2, "maxTc":I
    move-object v3, v13

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 1570
    .restart local v5  # "$i$f$forEach":I
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_206
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_25e

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Lkotlin/text/MatchResult;

    .local v9, "ot":Lkotlin/text/MatchResult;
    const/4 v10, 0x0

    .line 1409
    .local v10, "$i$a$-forEach-XmlProcessor$processRegataApk$2":I
    nop

    .line 1410
    nop

    .line 1409
    new-instance v11, Lkotlin/text/Regex;

    move-object/from16 v19, v3

    .end local v3  # "$this$forEach$iv":Ljava/lang/Iterable;
    .local v19, "$this$forEach$iv":Ljava/lang/Iterable;
    const-string v3, "takenCounter=\"(\\d+)\""

    invoke-direct {v11, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v9}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    move/from16 v20, v5

    move-object/from16 v21, v6

    move-object/from16 v22, v8

    const/4 v5, 0x0

    const/4 v6, 0x2

    const/4 v8, 0x0

    .end local v5  # "$i$f$forEach":I
    .end local v8  # "element$iv":Ljava/lang/Object;
    .local v20, "$i$f$forEach":I
    .local v22, "element$iv":Ljava/lang/Object;
    invoke-static {v11, v3, v5, v6, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1410
    if-eqz v3, :cond_251

    .line 1409
    nop

    .line 1410
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_251

    .line 1409
    nop

    .line 1410
    const/4 v5, 0x1

    invoke-interface {v3, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    if-eqz v3, :cond_251

    .line 1409
    nop

    .line 1410
    invoke-static {v3}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v3

    .line 1409
    if-eqz v3, :cond_251

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    goto :goto_252

    .line 1410
    :cond_251
    const/4 v3, 0x0

    .line 1409
    :goto_252
    nop

    .line 1411
    .local v3, "tc":I
    if-le v3, v2, :cond_256

    move v2, v3

    .line 1412
    :cond_256
    nop

    .line 1570
    .end local v3  # "tc":I
    .end local v9  # "ot":Lkotlin/text/MatchResult;
    .end local v10  # "$i$a$-forEach-XmlProcessor$processRegataApk$2":I
    move-object/from16 v3, v19

    move/from16 v5, v20

    move-object/from16 v6, v21

    .end local v22  # "element$iv":Ljava/lang/Object;
    goto :goto_206

    .line 1571
    .end local v19  # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v20  # "$i$f$forEach":I
    .local v3, "$this$forEach$iv":Ljava/lang/Iterable;
    .restart local v5  # "$i$f$forEach":I
    :cond_25e
    move-object/from16 v19, v3

    move/from16 v20, v5

    .line 1413
    .end local v3  # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5  # "$i$f$forEach":I
    add-int/lit8 v3, v2, 0x1

    .line 1414
    .local v3, "startTc":I
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    const-wide/16 v8, 0x3e8

    div-long/2addr v5, v8

    .line 1417
    .local v5, "nowTs":J
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    .line 1418
    .local v8, "novas":Ljava/lang/StringBuilder;
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_271
    if-ge v9, v15, :cond_309

    .line 1419
    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v10

    rem-int v10, v9, v10

    invoke-interface {v7, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;

    .line 1420
    .local v10, "t":Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;
    nop

    .line 1421
    invoke-virtual {v10}, Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;->getId()Ljava/lang/String;

    move-result-object v11

    .line 1422
    move/from16 v19, v2

    .end local v2  # "maxTc":I
    .local v19, "maxTc":I
    invoke-virtual {v10}, Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;->getTarget()Ljava/lang/String;

    move-result-object v2

    move-object/from16 v20, v7

    .end local v7  # "templates":Ljava/util/List;
    .local v20, "templates":Ljava/util/List;
    invoke-virtual {v10}, Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;->getNum()Ljava/lang/String;

    move-result-object v7

    .line 1423
    move-object/from16 v21, v13

    .end local v13  # "oldTasks":Ljava/util/List;
    .local v21, "oldTasks":Ljava/util/List;
    invoke-virtual {v10}, Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;->getVer()Ljava/lang/String;

    move-result-object v13

    move-object/from16 v22, v10

    .end local v10  # "t":Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;
    .local v22, "t":Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;
    add-int v10, v3, v9

    .line 1424
    move/from16 v23, v3

    .end local v3  # "startTc":I
    .local v23, "startTc":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v24, v15

    .end local v15  # "needed":I
    .local v24, "needed":I
    const-string v15, "<MyOldTask id=\""

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v11, "\" type=\"event_order\" eventType=\"Match3\" target=\""

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" user=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" num=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" ver=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" takenCounter=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" score=\"150\" realEndTime=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\"/>"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1420
    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1426
    sget-object v2, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1418
    .end local v22  # "t":Lcom/twntool/editor/core/XmlProcessor$processRegataApk$Tmpl;
    add-int/lit8 v9, v9, 0x1

    move/from16 v2, v19

    move-object/from16 v7, v20

    move-object/from16 v13, v21

    move/from16 v3, v23

    move/from16 v15, v24

    goto/16 :goto_271

    .end local v19  # "maxTc":I
    .end local v20  # "templates":Ljava/util/List;
    .end local v21  # "oldTasks":Ljava/util/List;
    .end local v23  # "startTc":I
    .end local v24  # "needed":I
    .restart local v2  # "maxTc":I
    .restart local v3  # "startTc":I
    .restart local v7  # "templates":Ljava/util/List;
    .restart local v13  # "oldTasks":Ljava/util/List;
    .restart local v15  # "needed":I
    :cond_309
    move/from16 v19, v2

    move/from16 v23, v3

    move-object/from16 v20, v7

    move-object/from16 v21, v13

    move/from16 v24, v15

    .line 1430
    .end local v2  # "maxTc":I
    .end local v3  # "startTc":I
    .end local v7  # "templates":Ljava/util/List;
    .end local v9  # "i":I
    .end local v13  # "oldTasks":Ljava/util/List;
    .end local v15  # "needed":I
    .restart local v19  # "maxTc":I
    .restart local v20  # "templates":Ljava/util/List;
    .restart local v21  # "oldTasks":Ljava/util/List;
    .restart local v23  # "startTc":I
    .restart local v24  # "needed":I
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "<Vars\\b"

    sget-object v7, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v2, v3, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, v12

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v7, 0x0

    const/4 v9, 0x2

    const/4 v10, 0x0

    invoke-static {v2, v3, v7, v9, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    if-nez v2, :cond_32d

    .line 1431
    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 1432
    .local v2, "mVars":Lkotlin/text/MatchResult;
    :cond_32d
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    .line 1433
    .local v3, "pos":I
    invoke-virtual {v12, v7, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v12, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1442
    .local v4, "blocoRegataNovo":Ljava/lang/String;
    const-string v7, "TakingTask"

    invoke-static {v4, v7}, Lcom/twntool/editor/core/XmlProcessor;->processRegataApk$resetVar(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 1443
    const-string v7, "visited"

    invoke-static {v4, v7}, Lcom/twntool/editor/core/XmlProcessor;->processRegataApk$resetVar(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 1444
    const-string v7, "HaveTeamList"

    invoke-static {v4, v7}, Lcom/twntool/editor/core/XmlProcessor;->processRegataApk$resetVar(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 1447
    invoke-interface/range {v27 .. v27}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    move-object/from16 v9, v26

    const/4 v10, 0x0

    .end local v26  # "blocoCenter":Ljava/lang/String;
    .local v9, "blocoCenter":Ljava/lang/String;
    invoke-virtual {v9, v10, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1448
    invoke-interface/range {v27 .. v27}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v10

    const/4 v11, 0x1

    add-int/2addr v10, v11

    invoke-virtual {v9, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 1447
    nop

    .line 1449
    .local v7, "blocoNovoCentro":Ljava/lang/String;
    invoke-interface/range {v25 .. v25}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    const/4 v11, 0x0

    invoke-virtual {v0, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1450
    invoke-interface/range {v25 .. v25}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v11

    const/4 v13, 0x1

    add-int/2addr v11, v13

    invoke-virtual {v0, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 1449
    nop

    .line 1451
    .local v10, "xmlNovo":Ljava/lang/String;
    move-object/from16 v11, v18

    invoke-static {v10, v11}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v11

    return-object v11
.end method

.method public final replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;
    .registers 13
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "name"  # Ljava/lang/String;
    .param p3, "newValue"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "name"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "newValue"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    sget-object v0, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v0, p2}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 32
    .local v0, "esc":Ljava/lang/String;
    new-instance v1, Lkotlin/text/Regex;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "<Var\\b[^>]*name=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\"[^>]*/>"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 33
    .local v1, "rx1":Lkotlin/text/Regex;
    new-instance v2, Lkotlin/text/Regex;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\"[^>]*>"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 36
    .local v2, "rx2":Lkotlin/text/Regex;
    invoke-static {p3}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 42
    .local v3, "safeValue":Ljava/lang/String;
    new-instance v4, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v4}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 43
    .local v4, "hits":Lkotlin/jvm/internal/Ref$IntRef;
    move-object v5, p1

    check-cast v5, Ljava/lang/CharSequence;

    new-instance v6, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda2;

    invoke-direct {v6, v4, v3}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda2;-><init>(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;)V

    invoke-virtual {v1, v5, v6}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v5

    .line 44
    .local v5, "out":Ljava/lang/String;
    iget v6, v4, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    const/4 v7, 0x1

    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    if-lez v6, :cond_72

    invoke-static {v5, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    return-object v6

    .line 45
    :cond_72
    move-object v6, p1

    check-cast v6, Ljava/lang/CharSequence;

    new-instance v8, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda3;

    invoke-direct {v8, v4, v3}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda3;-><init>(Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;)V

    invoke-virtual {v2, v6, v8}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v5

    .line 46
    iget v6, v4, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    if-lez v6, :cond_87

    invoke-static {v5, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    goto :goto_90

    :cond_87
    const/4 v6, 0x0

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-static {p1, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    :goto_90
    return-object v6
.end method

.method public final setBarnCapacity(Ljava/lang/String;I)Lkotlin/Pair;
    .registers 14
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "upgrades"  # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I)",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 440
    const/4 v0, 0x0

    invoke-static {p2, v0}, Lkotlin/ranges/RangesKt;->coerceAtLeast(II)I

    move-result v0

    .line 441
    .local v0, "whu":I
    invoke-static {v0}, Lkotlin/UInt;->constructor-impl(I)I

    move-result v1

    const v2, 0x1eadabcc

    xor-int/2addr v1, v2

    invoke-static {v1}, Lkotlin/UInt;->constructor-impl(I)I

    move-result v1

    .line 443
    .local v1, "dup":I
    move-object v2, p1

    .line 444
    .local v2, "out":Ljava/lang/String;
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    const-string v4, "WareHouseCashUpgrade"

    invoke-virtual {p0, v2, v4, v3}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .local v5, "out1":Ljava/lang/String;
    invoke-virtual {v3}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .line 445
    .local v3, "ok1":Z
    const-string v6, "i"

    if-eqz v3, :cond_37

    move-object v4, v5

    goto :goto_3f

    :cond_37
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v7

    invoke-direct {p0, v2, v4, v7, v6}, Lcom/twntool/editor/core/XmlProcessor;->insertVarTyped(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_3f
    move-object v2, v4

    .line 446
    invoke-static {v1}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticBackport1;->m(I)Ljava/lang/String;

    move-result-object v4

    const-string v7, "WHUdup"

    invoke-virtual {p0, v2, v7, v4}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .local v8, "out2":Ljava/lang/String;
    invoke-virtual {v4}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    .line 447
    .local v4, "ok2":Z
    if-eqz v4, :cond_5e

    move-object v6, v8

    goto :goto_66

    :cond_5e
    invoke-static {v1}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticBackport1;->m(I)Ljava/lang/String;

    move-result-object v9

    invoke-direct {p0, v2, v7, v9, v6}, Lcom/twntool/editor/core/XmlProcessor;->insertVarTyped(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    :goto_66
    move-object v2, v6

    .line 449
    invoke-virtual {p0, v0}, Lcom/twntool/editor/core/XmlProcessor;->barnCapacityFromUpgrades(I)I

    move-result v6

    .line 450
    .local v6, "cap":I
    invoke-static {v1}, Lkotlin/UInt;->toString-impl(I)Ljava/lang/String;

    move-result-object v7

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "✔ Celeiro: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " slots (upgrades="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", dup="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, ")."

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 451
    .local v7, "msg":Ljava/lang/String;
    invoke-static {v2, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    return-object v9
.end method

.method public final setBarnItems(Ljava/lang/String;Ljava/util/Map;)Lkotlin/Triple;
    .registers 21
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "updates"  # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;)",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    const-string v0, "xml"

    move-object/from16 v1, p1

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "updates"

    move-object/from16 v2, p2

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 494
    move-object/from16 v0, p1

    .line 495
    .local v0, "out":Ljava/lang/String;
    const/4 v3, 0x0

    .line 496
    .local v3, "changed":I
    const/4 v4, 0x0

    .line 497
    .local v4, "created":I
    new-instance v5, Lkotlin/text/Regex;

    const-string v6, "[A-Za-z0-9_]+"

    invoke-direct {v5, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 498
    .local v5, "nameRx":Lkotlin/text/Regex;
    invoke-interface/range {p2 .. p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_21
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_10a

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Map$Entry;

    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .local v8, "pid":Ljava/lang/String;
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Number;

    invoke-virtual {v7}, Ljava/lang/Number;->intValue()I

    move-result v7

    .line 499
    .local v7, "rawQty":I
    move-object v9, v8

    check-cast v9, Ljava/lang/CharSequence;

    invoke-virtual {v5, v9}, Lkotlin/text/Regex;->matches(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_fa

    .line 500
    const/4 v9, 0x0

    invoke-static {v7, v9}, Lkotlin/ranges/RangesKt;->coerceAtLeast(II)I

    move-result v10

    .line 501
    .local v10, "qty":I
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "Counter"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 502
    .local v11, "varName":Ljava/lang/String;
    invoke-static {v10}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v12

    move-object/from16 v13, p0

    invoke-virtual {v13, v0, v11, v12}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .local v14, "newXml":Ljava/lang/String;
    invoke-virtual {v12}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Boolean;

    invoke-virtual {v12}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v12

    .line 503
    .local v12, "ok":Z
    if-eqz v12, :cond_7e

    .line 504
    move-object v0, v14

    .line 505
    add-int/lit8 v3, v3, 0x1

    goto :goto_21

    .line 508
    :cond_7e
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "<Var name=\""

    invoke-virtual {v15, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v15, "\" v=\""

    invoke-virtual {v9, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v15, "\" t=\"i\"/>"

    invoke-virtual {v9, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 509
    .local v9, "novoVar":Ljava/lang/String;
    new-instance v15, Lkotlin/text/Regex;

    const-string v1, "<Globals\\b[^>]*>"

    invoke-direct {v15, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    move-object/from16 v16, v5

    .end local v5  # "nameRx":Lkotlin/text/Regex;
    .local v16, "nameRx":Lkotlin/text/Regex;
    const/4 v5, 0x0

    move-object/from16 v17, v6

    const/4 v6, 0x0

    invoke-static {v15, v1, v6, v2, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 510
    .local v1, "mGlob":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_100

    .line 511
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    .line 512
    .local v2, "pos":I
    invoke-virtual {v0, v6, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v6, "substring(...)"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\n\t\t"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 513
    nop

    .end local v1  # "mGlob":Lkotlin/text/MatchResult;
    .end local v2  # "pos":I
    .end local v7  # "rawQty":I
    .end local v8  # "pid":Ljava/lang/String;
    .end local v9  # "novoVar":Ljava/lang/String;
    .end local v10  # "qty":I
    .end local v11  # "varName":Ljava/lang/String;
    .end local v12  # "ok":Z
    .end local v14  # "newXml":Ljava/lang/String;
    add-int/lit8 v4, v4, 0x1

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v5, v16

    move-object/from16 v6, v17

    goto/16 :goto_21

    .line 499
    .end local v16  # "nameRx":Lkotlin/text/Regex;
    .restart local v5  # "nameRx":Lkotlin/text/Regex;
    .restart local v7  # "rawQty":I
    .restart local v8  # "pid":Ljava/lang/String;
    :cond_fa
    move-object/from16 v13, p0

    move-object/from16 v16, v5

    move-object/from16 v17, v6

    .line 498
    .end local v5  # "nameRx":Lkotlin/text/Regex;
    .end local v7  # "rawQty":I
    .end local v8  # "pid":Ljava/lang/String;
    .restart local v16  # "nameRx":Lkotlin/text/Regex;
    :cond_100
    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v5, v16

    move-object/from16 v6, v17

    goto/16 :goto_21

    .line 517
    .end local v16  # "nameRx":Lkotlin/text/Regex;
    .restart local v5  # "nameRx":Lkotlin/text/Regex;
    :cond_10a
    move-object/from16 v16, v5

    .end local v5  # "nameRx":Lkotlin/text/Regex;
    .restart local v16  # "nameRx":Lkotlin/text/Regex;
    new-instance v1, Lkotlin/Triple;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-direct {v1, v0, v2, v5}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v1
.end method

.method public final setM3Quantities(Ljava/lang/String;Ljava/util/Map;)Ljava/lang/String;
    .registers 54
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "data"  # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    move-object/from16 v0, p2

    const-string v1, "xml"

    move-object/from16 v2, p1

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v1, "data"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1133
    move-object/from16 v1, p1

    .line 1136
    .local v1, "out":Ljava/lang/String;
    new-instance v3, Lkotlin/text/Regex;

    const-string v4, "<Var\\b[^>]*\\bname=\"m3RainbowBall\"[^>]*/>"

    invoke-direct {v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1137
    .local v3, "anchorPat":Lkotlin/text/Regex;
    new-instance v4, Lkotlin/text/Regex;

    const-string v5, "<[Gg]lobal\\b[^>]*>"

    invoke-direct {v4, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v5, v1

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v4, v5, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 1138
    .local v4, "gOpen":Lkotlin/text/MatchResult;
    new-instance v5, Lkotlin/text/Regex;

    const-string v9, "</[Gg]lobal\\s*>"

    invoke-direct {v5, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v9, v1

    check-cast v9, Ljava/lang/CharSequence;

    invoke-static {v5, v9, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 1139
    .local v5, "gClose":Lkotlin/text/MatchResult;
    const/4 v9, 0x0

    .local v9, "gs":I
    const/4 v10, 0x0

    .line 1140
    .local v10, "ge":I
    const/4 v11, 0x1

    if-eqz v4, :cond_61

    if-eqz v5, :cond_61

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v12

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v13

    invoke-virtual {v13}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v13

    if-le v12, v13, :cond_61

    .line 1141
    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v12

    add-int/2addr v12, v11

    .line 1142
    .end local v9  # "gs":I
    .local v12, "gs":I
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v9

    .end local v10  # "ge":I
    .local v9, "ge":I
    goto :goto_94

    .line 1144
    .end local v12  # "gs":I
    .local v9, "gs":I
    .restart local v10  # "ge":I
    :cond_61
    move-object v12, v1

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v3, v12, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v12

    .line 1145
    .local v12, "anc":Lkotlin/text/MatchResult;
    if-eqz v12, :cond_8d

    .line 1146
    invoke-interface {v12}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v13

    invoke-virtual {v13}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v13

    add-int/lit16 v13, v13, -0x7d00

    invoke-static {v6, v13}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 1147
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v13

    invoke-interface {v12}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v14

    invoke-virtual {v14}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v14

    add-int/lit16 v14, v14, 0x7d00

    invoke-static {v13, v14}, Ljava/lang/Math;->min(II)I

    move-result v10

    move v12, v9

    move v9, v10

    goto :goto_94

    .line 1148
    :cond_8d
    const/4 v9, 0x0

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v10

    move v12, v9

    move v9, v10

    .line 1151
    .end local v10  # "ge":I
    .local v9, "ge":I
    .local v12, "gs":I
    :goto_94
    invoke-virtual {v1, v12, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    const-string v13, "substring(...)"

    invoke-static {v10, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1152
    .local v10, "win":Ljava/lang/String;
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    check-cast v14, Ljava/util/List;

    .line 1154
    .local v14, "faltando":Ljava/util/List;
    sget-object v15, Lcom/twntool/editor/core/XmlProcessor;->M3_VARS:Ljava/util/List;

    check-cast v15, Ljava/util/Collection;

    sget-object v16, Lcom/twntool/editor/data/PortedData;->INSTANCE:Lcom/twntool/editor/data/PortedData;

    invoke-virtual/range {v16 .. v16}, Lcom/twntool/editor/data/PortedData;->getLAB_BOOST_KEYS()Ljava/util/List;

    move-result-object v16

    move-object/from16 v11, v16

    check-cast v11, Ljava/lang/Iterable;

    invoke-static {v15, v11}, Lkotlin/collections/CollectionsKt;->plus(Ljava/util/Collection;Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v11

    .line 1155
    .local v11, "M3_AND_LAB":Ljava/util/List;
    invoke-interface {v11}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_ba
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    const-string v6, "quoteReplacement(...)"

    const-string v7, "\""

    const-string v8, "v=\""

    const-string v2, "\\bv=\"[^\"]*\""

    move-object/from16 v20, v4

    .end local v4  # "gOpen":Lkotlin/text/MatchResult;
    .local v20, "gOpen":Lkotlin/text/MatchResult;
    const-string v4, "\"[^>]*/>"

    if-eqz v16, :cond_18c

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v21, v5

    .end local v5  # "gClose":Lkotlin/text/MatchResult;
    .local v21, "gClose":Lkotlin/text/MatchResult;
    move-object/from16 v5, v16

    check-cast v5, Ljava/lang/String;

    .line 1156
    .local v5, "vname":Ljava/lang/String;
    invoke-interface {v0, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Ljava/lang/Long;

    if-eqz v16, :cond_171

    invoke-virtual/range {v16 .. v16}, Ljava/lang/Long;->longValue()J

    move-result-wide v22

    move-wide/from16 v24, v22

    .line 1157
    .local v24, "novoVal":J
    move-object/from16 v16, v11

    .end local v11  # "M3_AND_LAB":Ljava/util/List;
    .local v16, "M3_AND_LAB":Ljava/util/List;
    new-instance v11, Lkotlin/text/Regex;

    move-object/from16 v22, v15

    sget-object v15, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v15, v5}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v23, v9

    .end local v9  # "ge":I
    .local v23, "ge":I
    const-string v9, "<Var\\b[^>]*\\bname=\""

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v11, v0}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v0, v11

    .line 1158
    .local v0, "pattern":Lkotlin/text/Regex;
    move-object v4, v10

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v9, 0x0

    const/4 v11, 0x2

    const/4 v15, 0x0

    invoke-static {v0, v4, v9, v11, v15}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 1159
    .local v4, "mFound":Lkotlin/text/MatchResult;
    if-eqz v4, :cond_162

    .line 1160
    new-instance v9, Lkotlin/text/Regex;

    invoke-direct {v9, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    move v15, v12

    move-wide/from16 v11, v24

    .end local v12  # "gs":I
    .end local v24  # "novoVal":J
    .local v11, "novoVal":J
    .local v15, "gs":I
    invoke-virtual {v8, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v9, v2, v7}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 1161
    .local v2, "updated":Ljava/lang/String;
    move-object v7, v10

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v2}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v7, v8}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object/from16 v2, p1

    move-object/from16 v0, p2

    move v12, v15

    move-object/from16 v11, v16

    move-object/from16 v4, v20

    move-object/from16 v5, v21

    move-object/from16 v15, v22

    move/from16 v9, v23

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    .end local v2  # "updated":Ljava/lang/String;
    goto/16 :goto_ba

    .line 1162
    .end local v11  # "novoVal":J
    .end local v15  # "gs":I
    .restart local v12  # "gs":I
    .restart local v24  # "novoVal":J
    :cond_162
    move v15, v12

    move-wide/from16 v11, v24

    .end local v12  # "gs":I
    .end local v24  # "novoVal":J
    .restart local v11  # "novoVal":J
    .restart local v15  # "gs":I
    invoke-static {v11, v12}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v5, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    invoke-interface {v14, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_178

    .line 1156
    .end local v0  # "pattern":Lkotlin/text/Regex;
    .end local v4  # "mFound":Lkotlin/text/MatchResult;
    .end local v15  # "gs":I
    .end local v16  # "M3_AND_LAB":Ljava/util/List;
    .end local v23  # "ge":I
    .restart local v9  # "ge":I
    .local v11, "M3_AND_LAB":Ljava/util/List;
    .restart local v12  # "gs":I
    :cond_171
    move/from16 v23, v9

    move-object/from16 v16, v11

    move-object/from16 v22, v15

    move v15, v12

    .line 1155
    .end local v5  # "vname":Ljava/lang/String;
    .end local v9  # "ge":I
    .end local v11  # "M3_AND_LAB":Ljava/util/List;
    .end local v12  # "gs":I
    .restart local v15  # "gs":I
    .restart local v16  # "M3_AND_LAB":Ljava/util/List;
    .restart local v23  # "ge":I
    :goto_178
    move-object/from16 v2, p1

    move-object/from16 v0, p2

    move v12, v15

    move-object/from16 v11, v16

    move-object/from16 v4, v20

    move-object/from16 v5, v21

    move-object/from16 v15, v22

    move/from16 v9, v23

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    goto/16 :goto_ba

    .line 1164
    .end local v15  # "gs":I
    .end local v16  # "M3_AND_LAB":Ljava/util/List;
    .end local v21  # "gClose":Lkotlin/text/MatchResult;
    .end local v23  # "ge":I
    .local v5, "gClose":Lkotlin/text/MatchResult;
    .restart local v9  # "ge":I
    .restart local v11  # "M3_AND_LAB":Ljava/util/List;
    .restart local v12  # "gs":I
    :cond_18c
    move-object/from16 v21, v5

    move/from16 v23, v9

    move-object/from16 v16, v11

    move v15, v12

    .end local v5  # "gClose":Lkotlin/text/MatchResult;
    .end local v9  # "ge":I
    .end local v11  # "M3_AND_LAB":Ljava/util/List;
    .end local v12  # "gs":I
    .restart local v15  # "gs":I
    .restart local v16  # "M3_AND_LAB":Ljava/util/List;
    .restart local v21  # "gClose":Lkotlin/text/MatchResult;
    .restart local v23  # "ge":I
    invoke-interface {v14}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_197
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    const-string v9, "\" t=\"i\"/>"

    const-string v11, "\" v=\""

    const-string v12, "<Var name=\""

    if-eqz v5, :cond_235

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lkotlin/Pair;

    invoke-virtual {v5}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v22

    move-object/from16 v24, v0

    move-object/from16 v0, v22

    check-cast v0, Ljava/lang/String;

    .local v0, "vname":Ljava/lang/String;
    invoke-virtual {v5}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Number;

    move-object/from16 v22, v14

    move/from16 v25, v15

    .end local v14  # "faltando":Ljava/util/List;
    .end local v15  # "gs":I
    .local v22, "faltando":Ljava/util/List;
    .local v25, "gs":I
    invoke-virtual {v5}, Ljava/lang/Number;->longValue()J

    move-result-wide v14

    .line 1165
    .local v14, "novoVal":J
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 1166
    .local v5, "novaTag":Ljava/lang/String;
    move-object v9, v10

    check-cast v9, Ljava/lang/CharSequence;

    move-object/from16 v26, v0

    const/4 v0, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x2

    .end local v0  # "vname":Ljava/lang/String;
    .local v26, "vname":Ljava/lang/String;
    invoke-static {v3, v9, v11, v12, v0}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    .line 1167
    .local v9, "ref":Lkotlin/text/MatchResult;
    if-eqz v9, :cond_22d

    .line 1168
    invoke-interface {v9}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v0

    invoke-virtual {v10, v11, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v9}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v12, "\n    "

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    move-object/from16 v14, v22

    move-object/from16 v0, v24

    move/from16 v15, v25

    .end local v5  # "novaTag":Ljava/lang/String;
    .end local v9  # "ref":Lkotlin/text/MatchResult;
    .end local v14  # "novoVal":J
    .end local v26  # "vname":Ljava/lang/String;
    goto/16 :goto_197

    .line 1167
    .restart local v5  # "novaTag":Ljava/lang/String;
    .restart local v9  # "ref":Lkotlin/text/MatchResult;
    .restart local v14  # "novoVal":J
    .restart local v26  # "vname":Ljava/lang/String;
    :cond_22d
    move-object/from16 v14, v22

    move-object/from16 v0, v24

    move/from16 v15, v25

    goto/16 :goto_197

    .line 1171
    .end local v5  # "novaTag":Ljava/lang/String;
    .end local v9  # "ref":Lkotlin/text/MatchResult;
    .end local v22  # "faltando":Ljava/util/List;
    .end local v25  # "gs":I
    .end local v26  # "vname":Ljava/lang/String;
    .local v14, "faltando":Ljava/util/List;
    .restart local v15  # "gs":I
    :cond_235
    move-object/from16 v22, v14

    move/from16 v25, v15

    .end local v14  # "faltando":Ljava/util/List;
    .end local v15  # "gs":I
    .restart local v22  # "faltando":Ljava/util/List;
    .restart local v25  # "gs":I
    move/from16 v0, v25

    const/4 v5, 0x0

    .end local v25  # "gs":I
    .local v0, "gs":I
    invoke-virtual {v1, v5, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move/from16 v5, v23

    .end local v23  # "ge":I
    .local v5, "ge":I
    invoke-virtual {v1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .end local v0  # "gs":I
    .restart local v25  # "gs":I
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1174
    .end local v1  # "out":Ljava/lang/String;
    .local v0, "out":Ljava/lang/String;
    const-string v1, "lives_inf_days"

    move-object/from16 v14, p2

    invoke-interface {v14, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Long;

    move-object/from16 v23, v10

    move-object v15, v11

    .end local v10  # "win":Ljava/lang/String;
    .local v23, "win":Ljava/lang/String;
    const-wide/16 v10, 0x0

    if-eqz v1, :cond_277

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v26

    goto :goto_279

    :cond_277
    move-wide/from16 v26, v10

    .line 1175
    .local v26, "livesDays":J
    :goto_279
    cmp-long v1, v26, v10

    const v10, 0x15180

    const/16 v11, 0x3e8

    if-lez v1, :cond_2c5

    .line 1176
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v28

    move-object/from16 v24, v12

    move-object v1, v13

    int-to-long v12, v11

    div-long v28, v28, v12

    int-to-long v12, v10

    mul-long v12, v12, v26

    add-long v12, v28, v12

    .line 1177
    .local v12, "livesTs":J
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "<Var name=\"Lives_infTime_Match3\" v=\""

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 1178
    .local v9, "newVar":Ljava/lang/String;
    invoke-static {v9}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 1179
    .local v10, "safeVar":Ljava/lang/String;
    new-instance v11, Lkotlin/text/Regex;

    move-object/from16 v30, v3

    .end local v3  # "anchorPat":Lkotlin/text/Regex;
    .local v30, "anchorPat":Lkotlin/text/Regex;
    const-string v3, "(<Minigames\\b[^>]*>)((?:.|\\n)*?)(</Minigames>)"

    invoke-direct {v11, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v11

    .line 1180
    .local v3, "mgRe":Lkotlin/text/Regex;
    move-object v11, v0

    check-cast v11, Ljava/lang/CharSequence;

    move-object/from16 v31, v0

    .end local v0  # "out":Ljava/lang/String;
    .local v31, "out":Ljava/lang/String;
    new-instance v0, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda19;

    invoke-direct {v0, v10, v9}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda19;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v3, v11, v0}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v0

    .end local v31  # "out":Ljava/lang/String;
    .restart local v0  # "out":Ljava/lang/String;
    goto :goto_2cc

    .line 1175
    .end local v9  # "newVar":Ljava/lang/String;
    .end local v10  # "safeVar":Ljava/lang/String;
    .end local v12  # "livesTs":J
    .end local v30  # "anchorPat":Lkotlin/text/Regex;
    .local v3, "anchorPat":Lkotlin/text/Regex;
    :cond_2c5
    move-object/from16 v31, v0

    move-object/from16 v30, v3

    move-object/from16 v24, v12

    move-object v1, v13

    .line 1198
    .end local v3  # "anchorPat":Lkotlin/text/Regex;
    .restart local v30  # "anchorPat":Lkotlin/text/Regex;
    :goto_2cc
    const-string v3, "booster2x_days"

    invoke-interface {v14, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Long;

    if-eqz v3, :cond_2db

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    goto :goto_2dd

    :cond_2db
    const-wide/16 v9, 0x0

    .line 1199
    .local v9, "booster2xDays":J
    :goto_2dd
    const-wide/16 v11, 0x0

    cmp-long v3, v9, v11

    if-lez v3, :cond_33f

    .line 1200
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    move/from16 v29, v5

    move-object v13, v6

    const/16 v3, 0x3e8

    .end local v5  # "ge":I
    .local v29, "ge":I
    int-to-long v5, v3

    div-long/2addr v11, v5

    const v3, 0x15180

    int-to-long v5, v3

    mul-long/2addr v5, v9

    add-long/2addr v11, v5

    .line 1201
    .local v11, "ts":J
    sget-object v31, Lcom/twntool/editor/core/XmlProcessor;->BOOSTER2X_TEMPLATE:Ljava/lang/String;

    invoke-static {v11, v12}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v33

    const/16 v35, 0x4

    const/16 v36, 0x0

    const-string v32, "{ts}"

    const/16 v34, 0x0

    invoke-static/range {v31 .. v36}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 1202
    .local v3, "newBlock":Ljava/lang/String;
    invoke-static {v3}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 1203
    .local v5, "safe":Ljava/lang/String;
    new-instance v6, Lkotlin/text/Regex;

    move-object/from16 v28, v3

    .end local v3  # "newBlock":Ljava/lang/String;
    .local v28, "newBlock":Ljava/lang/String;
    const-string v3, "<TimedEntityManager\\s+configVersion=\"1\"\\s*/>"

    invoke-direct {v6, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v6

    .line 1204
    .local v3, "rSelfClose":Lkotlin/text/Regex;
    move-object v6, v0

    check-cast v6, Ljava/lang/CharSequence;

    invoke-virtual {v3, v6}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_32a

    move-object v6, v0

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3, v6, v5}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v31, v3

    goto :goto_33d

    .line 1205
    :cond_32a
    new-instance v6, Lkotlin/text/Regex;

    move-object/from16 v31, v3

    .end local v3  # "rSelfClose":Lkotlin/text/Regex;
    .local v31, "rSelfClose":Lkotlin/text/Regex;
    const-string v3, "<TimedEntityManager\\s+configVersion=\"1\"[^>]*>(?:.|\\n)*?</TimedEntityManager>"

    invoke-direct {v6, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1206
    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v6, v3, v5}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 1204
    :goto_33d
    move-object v0, v6

    goto :goto_342

    .line 1199
    .end local v11  # "ts":J
    .end local v28  # "newBlock":Ljava/lang/String;
    .end local v29  # "ge":I
    .end local v31  # "rSelfClose":Lkotlin/text/Regex;
    .local v5, "ge":I
    :cond_33f
    move/from16 v29, v5

    move-object v13, v6

    .line 1210
    .end local v5  # "ge":I
    .restart local v29  # "ge":I
    :goto_342
    sget-object v3, Lcom/twntool/editor/core/XmlProcessor;->GEM_BULLION_FIELDS:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_348
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    const-string v6, "\"/>"

    const-string v11, "\" t=\""

    const-string v12, "<Var\\b[^>]*?name=\""

    move-wide/from16 v31, v9

    .end local v9  # "booster2xDays":J
    .local v31, "booster2xDays":J
    const-string v10, "\n"

    if-eqz v5, :cond_646

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [Ljava/lang/String;

    .line 1211
    .local v5, "def":[Ljava/lang/String;
    const/16 v18, 0x0

    aget-object v9, v5, v18

    move-object/from16 v33, v3

    const/16 v17, 0x1

    .local v9, "key":Ljava/lang/String;
    aget-object v3, v5, v17

    move-object/from16 v34, v13

    const/16 v19, 0x2

    .local v3, "plainName":Ljava/lang/String;
    aget-object v13, v5, v19

    move-object/from16 v35, v15

    const/16 v28, 0x3

    .local v13, "xorName":Ljava/lang/String;
    aget-object v15, v5, v28

    .line 1212
    .local v15, "tAttr":Ljava/lang/String;
    invoke-interface {v14, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v36

    check-cast v36, Ljava/lang/Long;

    if-eqz v36, :cond_625

    invoke-virtual/range {v36 .. v36}, Ljava/lang/Long;->longValue()J

    move-result-wide v36

    move-wide/from16 v38, v36

    .line 1213
    .local v38, "novoVal":J
    move-object/from16 v40, v5

    move-object/from16 v37, v10

    move-object/from16 v36, v13

    move-wide/from16 v13, v38

    move-object/from16 v39, v6

    move-object/from16 v38, v9

    const-wide/16 v9, 0x0

    .end local v5  # "def":[Ljava/lang/String;
    .end local v9  # "key":Ljava/lang/String;
    .local v13, "novoVal":J
    .local v36, "xorName":Ljava/lang/String;
    .local v38, "key":Ljava/lang/String;
    .local v40, "def":[Ljava/lang/String;
    invoke-static {v9, v10, v13, v14}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v5

    .line 1214
    .local v5, "v":J
    const-wide/32 v9, 0x1e5d6a06

    xor-long/2addr v9, v5

    .line 1217
    .local v9, "xorVal":J
    move-wide/from16 v41, v13

    .end local v13  # "novoVal":J
    .local v41, "novoVal":J
    new-instance v13, Lkotlin/text/Regex;

    const-string v14, "(<[Gg]lobal\\b[^>]*>)((?:.|\\n)*?)(</[Gg]lobal>)"

    invoke-direct {v13, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1218
    .local v13, "globalRe":Lkotlin/text/Regex;
    move-object v14, v0

    check-cast v14, Ljava/lang/CharSequence;

    move-object/from16 v45, v1

    move-wide/from16 v43, v9

    const/4 v1, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x2

    .end local v9  # "xorVal":J
    .local v43, "xorVal":J
    invoke-static {v13, v14, v9, v10, v1}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v14

    .line 1219
    .local v14, "gm":Lkotlin/text/MatchResult;
    if-eqz v14, :cond_4ec

    .line 1220
    invoke-interface {v14}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1221
    .local v1, "innerG":Ljava/lang/String;
    new-instance v9, Lkotlin/text/Regex;

    sget-object v10, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v10, v3}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object/from16 v46, v13

    .end local v13  # "globalRe":Lkotlin/text/Regex;
    .local v46, "globalRe":Lkotlin/text/Regex;
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v9, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1222
    .local v9, "plainPat":Lkotlin/text/Regex;
    move-object v10, v1

    check-cast v10, Ljava/lang/CharSequence;

    move-object/from16 v47, v4

    move-object/from16 v48, v12

    const/4 v4, 0x2

    const/4 v12, 0x0

    const/4 v13, 0x0

    invoke-static {v9, v10, v13, v4, v12}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    .line 1223
    .local v10, "mPlain":Lkotlin/text/MatchResult;
    if-eqz v10, :cond_433

    .line 1224
    new-instance v4, Lkotlin/text/Regex;

    invoke-direct {v4, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v12

    check-cast v12, Ljava/lang/CharSequence;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v4, v12, v13}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 1225
    .local v4, "updated":Ljava/lang/String;
    move-object v12, v1

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v4}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    move-object/from16 v49, v4

    move-object/from16 v4, v34

    .end local v4  # "updated":Ljava/lang/String;
    .local v49, "updated":Ljava/lang/String;
    invoke-static {v13, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v9, v12, v13}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    move-object/from16 v13, v24

    move-object/from16 v24, v3

    move-object/from16 v3, v35

    move-wide/from16 v34, v5

    move-object/from16 v5, v39

    move-object/from16 v39, v1

    move-object v1, v12

    move-object/from16 v12, v37

    .end local v49  # "updated":Ljava/lang/String;
    goto :goto_48c

    .line 1227
    :cond_433
    move-object/from16 v4, v34

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v13, v24

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    move-object/from16 v24, v3

    move-object/from16 v3, v35

    .end local v3  # "plainName":Ljava/lang/String;
    .local v24, "plainName":Ljava/lang/String;
    invoke-virtual {v12, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    move-wide/from16 v34, v5

    move-object/from16 v5, v39

    .end local v5  # "v":J
    .local v34, "v":J
    invoke-virtual {v12, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 1228
    .local v6, "novaTag":Ljava/lang/String;
    move-object v12, v1

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v12}, Lkotlin/text/StringsKt;->trimEnd(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v12

    move-object/from16 v39, v1

    .end local v1  # "innerG":Ljava/lang/String;
    .local v39, "innerG":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v12, v37

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1223
    .end local v6  # "novaTag":Ljava/lang/String;
    :goto_48c
    nop

    .line 1230
    .end local v39  # "innerG":Ljava/lang/String;
    .restart local v1  # "innerG":Ljava/lang/String;
    invoke-interface {v14}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    move-object/from16 v37, v9

    const/4 v9, 0x0

    .end local v9  # "plainPat":Lkotlin/text/Regex;
    .local v37, "plainPat":Lkotlin/text/Regex;
    invoke-virtual {v0, v9, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v9, v45

    invoke-static {v6, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v39, v10

    .end local v10  # "mPlain":Lkotlin/text/MatchResult;
    .local v39, "mPlain":Lkotlin/text/MatchResult;
    invoke-interface {v14}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v10

    move-object/from16 v45, v12

    const/4 v12, 0x1

    invoke-interface {v10, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    invoke-interface {v14}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v12

    move-object/from16 v49, v5

    const/4 v5, 0x3

    invoke-interface {v12, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v14}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v12

    const/16 v17, 0x1

    add-int/lit8 v12, v12, 0x1

    invoke-virtual {v0, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v50, v0

    .end local v0  # "out":Ljava/lang/String;
    .local v50, "out":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .end local v50  # "out":Ljava/lang/String;
    .restart local v0  # "out":Ljava/lang/String;
    goto :goto_504

    .line 1219
    .end local v1  # "innerG":Ljava/lang/String;
    .end local v24  # "plainName":Ljava/lang/String;
    .end local v34  # "v":J
    .end local v37  # "plainPat":Lkotlin/text/Regex;
    .end local v39  # "mPlain":Lkotlin/text/MatchResult;
    .end local v46  # "globalRe":Lkotlin/text/Regex;
    .restart local v3  # "plainName":Ljava/lang/String;
    .restart local v5  # "v":J
    .restart local v13  # "globalRe":Lkotlin/text/Regex;
    :cond_4ec
    move-object/from16 v50, v0

    move-object/from16 v47, v4

    move-object/from16 v48, v12

    move-object/from16 v46, v13

    move-object/from16 v13, v24

    move-object/from16 v4, v34

    move-object/from16 v49, v39

    move-object/from16 v9, v45

    move-object/from16 v24, v3

    move-object/from16 v3, v35

    move-object/from16 v45, v37

    move-wide/from16 v34, v5

    .line 1234
    .end local v3  # "plainName":Ljava/lang/String;
    .end local v5  # "v":J
    .end local v13  # "globalRe":Lkotlin/text/Regex;
    .restart local v24  # "plainName":Ljava/lang/String;
    .restart local v34  # "v":J
    .restart local v46  # "globalRe":Lkotlin/text/Regex;
    :goto_504
    new-instance v1, Lkotlin/text/Regex;

    sget-object v5, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v6, v36

    .end local v36  # "xorName":Ljava/lang/String;
    .local v6, "xorName":Ljava/lang/String;
    invoke-virtual {v5, v6}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v12, v48

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v10, v47

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v1, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1235
    .local v1, "xorPat":Lkotlin/text/Regex;
    move-object v5, v0

    check-cast v5, Ljava/lang/CharSequence;

    move-object/from16 v28, v14

    const/4 v10, 0x0

    const/4 v12, 0x0

    const/4 v14, 0x2

    .end local v14  # "gm":Lkotlin/text/MatchResult;
    .local v28, "gm":Lkotlin/text/MatchResult;
    invoke-static {v1, v5, v12, v14, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 1236
    .local v5, "mXor":Lkotlin/text/MatchResult;
    if-eqz v5, :cond_579

    .line 1237
    new-instance v10, Lkotlin/text/Regex;

    invoke-direct {v10, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v11

    check-cast v11, Ljava/lang/CharSequence;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    move-object v14, v8

    move-object/from16 v36, v9

    move-wide/from16 v8, v43

    .end local v43  # "xorVal":J
    .local v8, "xorVal":J
    invoke-virtual {v12, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v11, v12}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 1238
    .local v10, "updated":Ljava/lang/String;
    move-object v11, v0

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v10}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v11, v12}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object/from16 v37, v1

    move-object/from16 v39, v5

    move-object/from16 v43, v6

    move-object/from16 v1, v36

    .end local v10  # "updated":Ljava/lang/String;
    goto/16 :goto_615

    .line 1241
    .end local v8  # "xorVal":J
    .restart local v43  # "xorVal":J
    :cond_579
    move-object v14, v8

    move-object/from16 v36, v9

    move-wide/from16 v8, v43

    .end local v43  # "xorVal":J
    .restart local v8  # "xorVal":J
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    move-object/from16 v11, v49

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 1242
    .local v10, "novaTag":Ljava/lang/String;
    new-instance v11, Lkotlin/text/Regex;

    const-string v12, "</root\\s*>"

    invoke-direct {v11, v12}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v12, v0

    check-cast v12, Ljava/lang/CharSequence;

    move-object/from16 v37, v1

    move-object/from16 v39, v5

    move-object/from16 v43, v6

    const/4 v1, 0x0

    const/4 v5, 0x2

    const/4 v6, 0x0

    .end local v1  # "xorPat":Lkotlin/text/Regex;
    .end local v5  # "mXor":Lkotlin/text/MatchResult;
    .end local v6  # "xorName":Ljava/lang/String;
    .local v37, "xorPat":Lkotlin/text/Regex;
    .local v39, "mXor":Lkotlin/text/MatchResult;
    .local v43, "xorName":Ljava/lang/String;
    invoke-static {v11, v12, v1, v5, v6}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v11

    .line 1243
    .local v11, "rootM":Lkotlin/text/MatchResult;
    if-eqz v11, :cond_5fb

    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {v0, v1, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v1, v36

    invoke-static {v5, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v0, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v12, v45

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v10, v5

    goto :goto_615

    .line 1244
    :cond_5fb
    move-object/from16 v1, v36

    move-object/from16 v12, v45

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v10, v5

    .line 1236
    .end local v10  # "novaTag":Ljava/lang/String;
    .end local v11  # "rootM":Lkotlin/text/MatchResult;
    :goto_615
    move-object v0, v10

    move-object v15, v3

    move-object/from16 v24, v13

    move-object v8, v14

    move-wide/from16 v9, v31

    move-object/from16 v3, v33

    move-object/from16 v14, p2

    move-object v13, v4

    move-object/from16 v4, v47

    .end local v8  # "xorVal":J
    .end local v15  # "tAttr":Ljava/lang/String;
    .end local v24  # "plainName":Ljava/lang/String;
    .end local v28  # "gm":Lkotlin/text/MatchResult;
    .end local v34  # "v":J
    .end local v37  # "xorPat":Lkotlin/text/Regex;
    .end local v38  # "key":Ljava/lang/String;
    .end local v39  # "mXor":Lkotlin/text/MatchResult;
    .end local v40  # "def":[Ljava/lang/String;
    .end local v41  # "novoVal":J
    .end local v43  # "xorName":Ljava/lang/String;
    .end local v46  # "globalRe":Lkotlin/text/Regex;
    goto/16 :goto_348

    .line 1212
    .restart local v3  # "plainName":Ljava/lang/String;
    .local v5, "def":[Ljava/lang/String;
    .local v9, "key":Ljava/lang/String;
    .local v13, "xorName":Ljava/lang/String;
    .restart local v15  # "tAttr":Ljava/lang/String;
    :cond_625
    move-object/from16 v50, v0

    move-object/from16 v47, v4

    move-object/from16 v40, v5

    move-object v14, v8

    move-object/from16 v38, v9

    move-object/from16 v43, v13

    move-object/from16 v13, v24

    move-object/from16 v4, v34

    move-object/from16 v24, v3

    move-object/from16 v3, v35

    .end local v0  # "out":Ljava/lang/String;
    .end local v3  # "plainName":Ljava/lang/String;
    .end local v5  # "def":[Ljava/lang/String;
    .end local v9  # "key":Ljava/lang/String;
    .end local v13  # "xorName":Ljava/lang/String;
    .restart local v24  # "plainName":Ljava/lang/String;
    .restart local v38  # "key":Ljava/lang/String;
    .restart local v40  # "def":[Ljava/lang/String;
    .restart local v43  # "xorName":Ljava/lang/String;
    .restart local v50  # "out":Ljava/lang/String;
    move-object v15, v3

    move-object/from16 v24, v13

    move-wide/from16 v9, v31

    move-object/from16 v3, v33

    move-object/from16 v14, p2

    move-object v13, v4

    move-object/from16 v4, v47

    goto/16 :goto_348

    .line 1249
    .end local v15  # "tAttr":Ljava/lang/String;
    .end local v24  # "plainName":Ljava/lang/String;
    .end local v38  # "key":Ljava/lang/String;
    .end local v40  # "def":[Ljava/lang/String;
    .end local v43  # "xorName":Ljava/lang/String;
    .end local v50  # "out":Ljava/lang/String;
    .restart local v0  # "out":Ljava/lang/String;
    :cond_646
    move-object/from16 v50, v0

    move-object/from16 v47, v4

    move-object v0, v6

    move-object v14, v8

    move-object v5, v10

    move-object v4, v13

    move-object v3, v15

    move-object/from16 v13, v24

    .end local v0  # "out":Ljava/lang/String;
    .restart local v50  # "out":Ljava/lang/String;
    sget-object v6, Lcom/twntool/editor/core/XmlProcessor;->PLAIN_ONLY_FIELDS:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move-object/from16 v8, v50

    .end local v50  # "out":Ljava/lang/String;
    .local v8, "out":Ljava/lang/String;
    :goto_659
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_829

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [Ljava/lang/String;

    .line 1250
    .local v9, "def":[Ljava/lang/String;
    const/4 v10, 0x0

    aget-object v15, v9, v10

    move-object/from16 v24, v6

    const/4 v10, 0x1

    .local v15, "key":Ljava/lang/String;
    aget-object v6, v9, v10

    move-object/from16 v33, v14

    const/4 v10, 0x2

    .local v6, "plainName":Ljava/lang/String;
    aget-object v14, v9, v10

    .line 1251
    .local v14, "tAttr":Ljava/lang/String;
    move-object/from16 v10, p2

    invoke-interface {v10, v15}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v34

    check-cast v34, Ljava/lang/Long;

    if-eqz v34, :cond_802

    invoke-virtual/range {v34 .. v34}, Ljava/lang/Long;->longValue()J

    move-result-wide v34

    move-wide/from16 v36, v34

    .line 1252
    .local v36, "novoVal":J
    move-object/from16 v39, v0

    move-object/from16 v45, v1

    move-object/from16 v34, v9

    move-object/from16 v35, v15

    move-wide/from16 v9, v36

    const-wide/16 v0, 0x0

    move-object/from16 v36, v14

    .end local v14  # "tAttr":Ljava/lang/String;
    .end local v15  # "key":Ljava/lang/String;
    .local v9, "novoVal":J
    .local v34, "def":[Ljava/lang/String;
    .local v35, "key":Ljava/lang/String;
    .local v36, "tAttr":Ljava/lang/String;
    invoke-static {v0, v1, v9, v10}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v14

    .line 1253
    .local v14, "v":J
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "(<[Gg]lobal\\b[^>]*>)((?:.|\\n)*?)(</[Gg]lobal>)"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1254
    .local v0, "globalRe":Lkotlin/text/Regex;
    move-object v1, v8

    check-cast v1, Ljava/lang/CharSequence;

    move-object/from16 v40, v8

    move-wide/from16 v37, v9

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x2

    .end local v8  # "out":Ljava/lang/String;
    .end local v9  # "novoVal":J
    .local v37, "novoVal":J
    .local v40, "out":Ljava/lang/String;
    invoke-static {v0, v1, v9, v10, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    if-nez v1, :cond_6bd

    move-object/from16 v43, v2

    move-object/from16 v48, v12

    move-object/from16 v12, v39

    move-object/from16 v2, v40

    move-object/from16 v8, v45

    move-object/from16 v39, v3

    move-object/from16 v40, v4

    move-object/from16 v45, v5

    goto/16 :goto_816

    .line 1255
    .local v1, "gm":Lkotlin/text/MatchResult;
    :cond_6bd
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 1256
    .local v8, "innerG":Ljava/lang/String;
    new-instance v9, Lkotlin/text/Regex;

    sget-object v10, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v10, v6}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object/from16 v41, v0

    .end local v0  # "globalRe":Lkotlin/text/Regex;
    .local v41, "globalRe":Lkotlin/text/Regex;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v10, v47

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v9, v0}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v0, v9

    .line 1257
    .local v0, "plainPat":Lkotlin/text/Regex;
    move-object v9, v8

    check-cast v9, Ljava/lang/CharSequence;

    move-object/from16 v42, v1

    move-object/from16 v48, v12

    const/4 v1, 0x0

    const/4 v10, 0x0

    const/4 v12, 0x2

    .end local v1  # "gm":Lkotlin/text/MatchResult;
    .local v42, "gm":Lkotlin/text/MatchResult;
    invoke-static {v0, v9, v10, v12, v1}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    .line 1258
    .local v9, "mPlain":Lkotlin/text/MatchResult;
    if-eqz v9, :cond_739

    .line 1259
    new-instance v1, Lkotlin/text/Regex;

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v9}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v10

    check-cast v10, Ljava/lang/CharSequence;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v43, v2

    move-object/from16 v2, v33

    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v1, v10, v12}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1260
    .local v1, "updated":Ljava/lang/String;
    move-object v10, v8

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v1}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v10, v12}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v10, v36

    move-object/from16 v12, v39

    move-object/from16 v36, v0

    .end local v1  # "updated":Ljava/lang/String;
    goto :goto_790

    .line 1262
    :cond_739
    move-object/from16 v43, v2

    move-object/from16 v2, v33

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v10, v36

    .end local v36  # "tAttr":Ljava/lang/String;
    .local v10, "tAttr":Ljava/lang/String;
    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v12, v39

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1263
    .local v1, "novaTag":Ljava/lang/String;
    move-object/from16 v33, v8

    check-cast v33, Ljava/lang/CharSequence;

    invoke-static/range {v33 .. v33}, Lkotlin/text/StringsKt;->trimEnd(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v33

    move-object/from16 v36, v0

    .end local v0  # "plainPat":Lkotlin/text/Regex;
    .local v36, "plainPat":Lkotlin/text/Regex;
    invoke-virtual/range {v33 .. v33}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    move-object/from16 v33, v2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 1258
    .end local v1  # "novaTag":Ljava/lang/String;
    :goto_790
    move-object v0, v1

    .line 1265
    .end local v8  # "innerG":Ljava/lang/String;
    .local v0, "innerG":Ljava/lang/String;
    invoke-interface/range {v42 .. v42}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v1

    move-object/from16 v2, v40

    const/4 v8, 0x0

    .end local v40  # "out":Ljava/lang/String;
    .local v2, "out":Ljava/lang/String;
    invoke-virtual {v2, v8, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v8, v45

    invoke-static {v1, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v39, v3

    invoke-interface/range {v42 .. v42}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v3

    move-object/from16 v40, v4

    const/4 v4, 0x1

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-interface/range {v42 .. v42}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    move-object/from16 v45, v5

    const/4 v5, 0x3

    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-interface/range {v42 .. v42}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v28

    invoke-virtual/range {v28 .. v28}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v28

    const/16 v17, 0x1

    add-int/lit8 v5, v28, 0x1

    invoke-virtual {v2, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v28, v6

    .end local v6  # "plainName":Ljava/lang/String;
    .local v28, "plainName":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v1, v8

    move-object/from16 v6, v24

    move-object/from16 v14, v33

    move-object/from16 v3, v39

    move-object/from16 v4, v40

    move-object/from16 v2, v43

    move-object/from16 v5, v45

    move-object v8, v0

    move-object v0, v12

    move-object/from16 v12, v48

    .end local v2  # "out":Ljava/lang/String;
    .end local v9  # "mPlain":Lkotlin/text/MatchResult;
    .end local v10  # "tAttr":Ljava/lang/String;
    .end local v14  # "v":J
    .end local v28  # "plainName":Ljava/lang/String;
    .end local v34  # "def":[Ljava/lang/String;
    .end local v35  # "key":Ljava/lang/String;
    .end local v36  # "plainPat":Lkotlin/text/Regex;
    .end local v37  # "novoVal":J
    .end local v41  # "globalRe":Lkotlin/text/Regex;
    .end local v42  # "gm":Lkotlin/text/MatchResult;
    .local v0, "out":Ljava/lang/String;
    goto/16 :goto_659

    .line 1251
    .end local v0  # "out":Ljava/lang/String;
    .restart local v6  # "plainName":Ljava/lang/String;
    .local v8, "out":Ljava/lang/String;
    .local v9, "def":[Ljava/lang/String;
    .local v14, "tAttr":Ljava/lang/String;
    .restart local v15  # "key":Ljava/lang/String;
    :cond_802
    move-object/from16 v43, v2

    move-object/from16 v39, v3

    move-object/from16 v40, v4

    move-object/from16 v45, v5

    move-object/from16 v28, v6

    move-object v2, v8

    move-object/from16 v34, v9

    move-object/from16 v48, v12

    move-object v10, v14

    move-object/from16 v35, v15

    move-object v12, v0

    move-object v8, v1

    .line 1249
    .end local v6  # "plainName":Ljava/lang/String;
    .end local v8  # "out":Ljava/lang/String;
    .end local v9  # "def":[Ljava/lang/String;
    .end local v14  # "tAttr":Ljava/lang/String;
    .end local v15  # "key":Ljava/lang/String;
    .restart local v2  # "out":Ljava/lang/String;
    :goto_816
    move-object v1, v8

    move-object v0, v12

    move-object/from16 v6, v24

    move-object/from16 v14, v33

    move-object/from16 v3, v39

    move-object/from16 v4, v40

    move-object/from16 v5, v45

    move-object/from16 v12, v48

    move-object v8, v2

    move-object/from16 v2, v43

    goto/16 :goto_659

    .line 1269
    .end local v2  # "out":Ljava/lang/String;
    .restart local v8  # "out":Ljava/lang/String;
    :cond_829
    move-object v2, v8

    move-object v8, v1

    .end local v8  # "out":Ljava/lang/String;
    .restart local v2  # "out":Ljava/lang/String;
    const-string v0, "currency_provider_amount"

    move-object/from16 v1, p2

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    .line 1270
    .local v0, "cpAmount":Ljava/lang/Long;
    if-eqz v0, :cond_8a6

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-ltz v3, :cond_8a6

    .line 1271
    new-instance v3, Lkotlin/text/Regex;

    .line 1272
    nop

    .line 1274
    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1271
    const-string v5, "(<DataElem\\s+name=\"CurrencyProvider\"[^>]*>.*?<DataElem\\s+name=\"Amount\"\\s+type=\"int\"\\s+value=\")[^\"]*(\")"

    invoke-direct {v3, v5, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1276
    .local v3, "cpRe":Lkotlin/text/Regex;
    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x2

    const/4 v7, 0x0

    invoke-static {v3, v4, v5, v6, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 1277
    .local v4, "cpMatch":Lkotlin/text/MatchResult;
    if-eqz v4, :cond_8a6

    .line 1278
    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v2, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1279
    invoke-interface {v4}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    const/4 v7, 0x1

    invoke-interface {v5, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v9

    const/4 v10, 0x2

    invoke-interface {v9, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    .line 1280
    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v10

    add-int/2addr v10, v7

    invoke-virtual {v2, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 1278
    move-object v2, v5

    .line 1285
    .end local v3  # "cpRe":Lkotlin/text/Regex;
    .end local v4  # "cpMatch":Lkotlin/text/MatchResult;
    :cond_8a6
    const-string v3, "train_journey_amount"

    invoke-interface {v1, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Long;

    .line 1286
    .local v3, "tjAmount":Ljava/lang/Long;
    if-eqz v3, :cond_91d

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-ltz v4, :cond_91d

    .line 1288
    new-instance v4, Lkotlin/text/Regex;

    .line 1289
    nop

    .line 1291
    sget-object v5, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 1288
    const-string v6, "(<DataElem\\s+name=\"TrainJourney\"\\s+type=\"dataStore\">.*?<DataElem\\s+name=\"CurrencyProvider\"[^>]*>.*?</DataElem>)"

    invoke-direct {v4, v6, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 1293
    .local v4, "tjBlockRe":Lkotlin/text/Regex;
    move-object v5, v2

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v9, 0x0

    invoke-static {v4, v5, v6, v7, v9}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 1294
    .local v5, "bm":Lkotlin/text/MatchResult;
    if-eqz v5, :cond_91d

    .line 1295
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v6

    .line 1296
    .local v6, "block":Ljava/lang/String;
    new-instance v7, Lkotlin/text/Regex;

    const-string v9, "(<DataElem\\s+name=\"Amount\"\\s+type=\"int\"\\s+value=\")[^\"]*(\")"

    invoke-direct {v7, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1297
    .local v7, "amountRe":Lkotlin/text/Regex;
    move-object v9, v6

    check-cast v9, Ljava/lang/CharSequence;

    new-instance v10, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda20;

    invoke-direct {v10, v3}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda20;-><init>(Ljava/lang/Long;)V

    invoke-virtual {v7, v9, v10}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v9

    .line 1300
    .local v9, "newBlock":Ljava/lang/String;
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    const/4 v11, 0x0

    invoke-virtual {v2, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v11

    const/4 v12, 0x1

    add-int/2addr v11, v12

    invoke-virtual {v2, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1304
    .end local v4  # "tjBlockRe":Lkotlin/text/Regex;
    .end local v5  # "bm":Lkotlin/text/MatchResult;
    .end local v6  # "block":Ljava/lang/String;
    .end local v7  # "amountRe":Lkotlin/text/Regex;
    .end local v9  # "newBlock":Ljava/lang/String;
    :cond_91d
    return-object v2
.end method

.method public final unlockAchievements(Ljava/lang/String;)Lkotlin/Triple;
    .registers 26
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "xml"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 954
    new-instance v1, Lkotlin/text/Regex;

    const-string v2, "AchReward_([A-Za-z0-9_]+)"

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-static {v1, v2, v3, v4, v5}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v1

    new-instance v2, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda11;

    invoke-direct {v2}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda11;-><init>()V

    .line 955
    invoke-static {v1, v2}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v1

    invoke-static {v1}, Lkotlin/sequences/SequencesKt;->toSet(Lkotlin/sequences/Sequence;)Ljava/util/Set;

    move-result-object v1

    .line 954
    nop

    .line 956
    .local v1, "presentes":Ljava/util/Set;
    sget-object v2, Lcom/twntool/editor/core/XmlProcessor;->ACHIEVEMENT_REWARDS:Ljava/util/List;

    check-cast v2, Ljava/lang/Iterable;

    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->toSet(Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v2

    move-object v6, v1

    check-cast v6, Ljava/lang/Iterable;

    invoke-static {v2, v6}, Lkotlin/collections/SetsKt;->plus(Ljava/util/Set;Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v2

    .line 958
    .local v2, "todos":Ljava/util/Set;
    move-object/from16 v6, p1

    .line 959
    .local v6, "out":Ljava/lang/String;
    const/4 v7, 0x0

    .line 960
    .local v7, "atualizados":I
    const/4 v8, 0x0

    .line 961
    .local v8, "criados":I
    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_3d
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_227

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .line 962
    .local v10, "nome":Ljava/lang/String;
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "AchReward_"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 963
    .local v11, "varName":Ljava/lang/String;
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "<Var name=\""

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, "\" v=\"4\" t=\"i\"/>"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    .line 964
    .local v12, "newTag":Ljava/lang/String;
    invoke-static {v12}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 965
    .local v13, "safe":Ljava/lang/String;
    new-instance v14, Lkotlin/text/Regex;

    sget-object v15, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v15, v11}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<Var\\s+name=\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v15, "\"[^/]*/>"

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v14, v3, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, v14

    .line 966
    .local v3, "pattern":Lkotlin/text/Regex;
    move-object v14, v6

    check-cast v14, Ljava/lang/CharSequence;

    invoke-virtual {v3, v14}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v14

    if-eqz v14, :cond_bd

    .line 967
    move-object v14, v6

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3, v14, v13}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 968
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v18, v1

    move-object/from16 v19, v2

    move-object/from16 v20, v3

    goto/16 :goto_16a

    .line 970
    :cond_bd
    new-instance v14, Lkotlin/text/Regex;

    const-string v15, "</Global\\s*>"

    sget-object v5, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v14, v15, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v5, v6

    check-cast v5, Ljava/lang/CharSequence;

    move-object/from16 v18, v1

    const/4 v0, 0x2

    const/4 v1, 0x0

    const/4 v15, 0x0

    .end local v1  # "presentes":Ljava/util/Set;
    .local v18, "presentes":Ljava/util/Set;
    invoke-static {v14, v5, v15, v0, v1}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 971
    .local v5, "mG":Lkotlin/text/MatchResult;
    const-string v0, "\n"

    const-string v1, "substring(...)"

    if-eqz v5, :cond_116

    .line 972
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v14

    invoke-virtual {v14}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v14

    invoke-virtual {v6, v15, v14}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v15

    invoke-virtual {v6, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object/from16 v19, v2

    move-object/from16 v20, v3

    move-object/from16 v21, v5

    goto :goto_168

    .line 974
    :cond_116
    new-instance v14, Lkotlin/text/Regex;

    const-string v15, "</root\\s*>"

    move-object/from16 v19, v2

    .end local v2  # "todos":Ljava/util/Set;
    .local v19, "todos":Ljava/util/Set;
    sget-object v2, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v14, v15, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v2, v6

    check-cast v2, Ljava/lang/CharSequence;

    move-object/from16 v20, v3

    move-object/from16 v21, v5

    const/4 v3, 0x2

    const/4 v5, 0x0

    const/4 v15, 0x0

    .end local v3  # "pattern":Lkotlin/text/Regex;
    .end local v5  # "mG":Lkotlin/text/MatchResult;
    .local v20, "pattern":Lkotlin/text/Regex;
    .local v21, "mG":Lkotlin/text/MatchResult;
    invoke-static {v14, v2, v15, v3, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 975
    .local v2, "mR":Lkotlin/text/MatchResult;
    if-eqz v2, :cond_168

    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    invoke-virtual {v6, v15, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {v6, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 977
    .end local v2  # "mR":Lkotlin/text/MatchResult;
    :cond_168
    :goto_168
    add-int/lit8 v8, v8, 0x1

    .line 980
    .end local v21  # "mG":Lkotlin/text/MatchResult;
    :goto_16a
    sget-object v0, Lcom/twntool/editor/core/XmlProcessor;->ACHIEVEMENT_COUNTERS:Ljava/util/Map;

    invoke-interface {v0, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    if-nez v0, :cond_17f

    move-object/from16 v0, p1

    move-object/from16 v1, v18

    move-object/from16 v2, v19

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    goto/16 :goto_3d

    .line 981
    .local v0, "counters":Ljava/util/List;
    :cond_17f
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_183
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_218

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lkotlin/Pair;

    invoke-virtual {v2}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .local v3, "counterName":Ljava/lang/String;
    invoke-virtual {v2}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->longValue()J

    move-result-wide v14

    .line 982
    .local v14, "minValue":J
    new-instance v2, Lkotlin/text/Regex;

    sget-object v5, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v5, v3}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v21, v0

    .end local v0  # "counters":Ljava/util/List;
    .local v21, "counters":Ljava/util/List;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "\"\\s+v=\"(\\d+)\""

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 983
    sget-object v5, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    .line 982
    invoke-direct {v2, v0, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 983
    move-object v0, v6

    check-cast v0, Ljava/lang/CharSequence;

    move-object/from16 v16, v1

    move-object/from16 v17, v4

    const/4 v1, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v2, v0, v5, v1, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 982
    nop

    .line 984
    .local v0, "mCur":Lkotlin/text/MatchResult;
    if-eqz v0, :cond_1f0

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_1f0

    const/4 v1, 0x1

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    if-eqz v1, :cond_1f0

    invoke-static {v1}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v1

    if-eqz v1, :cond_1f0

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    goto :goto_1f2

    :cond_1f0
    const-wide/16 v1, 0x0

    .line 985
    .local v1, "curVal":J
    :goto_1f2
    cmp-long v22, v1, v14

    if-gez v22, :cond_20c

    .line 986
    invoke-static {v14, v15}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v4

    const-string v5, "i"

    move-object/from16 v23, v0

    move-object/from16 v0, p0

    .end local v0  # "mCur":Lkotlin/text/MatchResult;
    .local v23, "mCur":Lkotlin/text/MatchResult;
    invoke-direct {v0, v6, v3, v4, v5}, Lcom/twntool/editor/core/XmlProcessor;->upsertVarTyped(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v1, v16

    move-object/from16 v4, v17

    move-object/from16 v0, v21

    .end local v1  # "curVal":J
    .end local v3  # "counterName":Ljava/lang/String;
    .end local v14  # "minValue":J
    .end local v23  # "mCur":Lkotlin/text/MatchResult;
    goto/16 :goto_183

    .line 985
    .restart local v0  # "mCur":Lkotlin/text/MatchResult;
    .restart local v1  # "curVal":J
    .restart local v3  # "counterName":Ljava/lang/String;
    .restart local v14  # "minValue":J
    :cond_20c
    move-object/from16 v23, v0

    move-object/from16 v0, p0

    .end local v0  # "mCur":Lkotlin/text/MatchResult;
    .restart local v23  # "mCur":Lkotlin/text/MatchResult;
    move-object/from16 v1, v16

    move-object/from16 v4, v17

    move-object/from16 v0, v21

    goto/16 :goto_183

    .line 981
    .end local v1  # "curVal":J
    .end local v3  # "counterName":Ljava/lang/String;
    .end local v14  # "minValue":J
    .end local v21  # "counters":Ljava/util/List;
    .end local v23  # "mCur":Lkotlin/text/MatchResult;
    .local v0, "counters":Ljava/util/List;
    :cond_218
    move-object/from16 v21, v0

    move-object/from16 v0, p0

    .end local v0  # "counters":Ljava/util/List;
    .restart local v21  # "counters":Ljava/util/List;
    move-object/from16 v0, p1

    move-object/from16 v1, v18

    move-object/from16 v2, v19

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    goto/16 :goto_3d

    .line 990
    .end local v10  # "nome":Ljava/lang/String;
    .end local v11  # "varName":Ljava/lang/String;
    .end local v12  # "newTag":Ljava/lang/String;
    .end local v13  # "safe":Ljava/lang/String;
    .end local v18  # "presentes":Ljava/util/Set;
    .end local v19  # "todos":Ljava/util/Set;
    .end local v20  # "pattern":Lkotlin/text/Regex;
    .end local v21  # "counters":Ljava/util/List;
    .local v1, "presentes":Ljava/util/Set;
    .local v2, "todos":Ljava/util/Set;
    :cond_227
    move-object/from16 v18, v1

    move-object/from16 v19, v2

    .end local v1  # "presentes":Ljava/util/Set;
    .end local v2  # "todos":Ljava/util/Set;
    .restart local v18  # "presentes":Ljava/util/Set;
    .restart local v19  # "todos":Ljava/util/Set;
    new-instance v1, Lkotlin/Triple;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-direct {v1, v6, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v1
.end method

.method public final unlockAvatars(Ljava/lang/String;)Lkotlin/Triple;
    .registers 20
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "xml"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 101
    new-instance v1, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 102
    .local v1, "atualizados":Lkotlin/jvm/internal/Ref$IntRef;
    new-instance v2, Lkotlin/text/Regex;

    const-string v3, "<Var\\s+name=\"(Unlocked_ava\\d+)\"[^/]*/>"

    invoke-direct {v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    new-instance v4, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda8;

    invoke-direct {v4, v1}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda8;-><init>(Lkotlin/jvm/internal/Ref$IntRef;)V

    invoke-virtual {v2, v3, v4}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v2

    .line 107
    .local v2, "out":Ljava/lang/String;
    new-instance v3, Lkotlin/text/Regex;

    const-string v4, "<Var\\s+name=\"(Unlocked_ava\\d+)\""

    invoke-direct {v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 108
    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x2

    const/4 v7, 0x0

    invoke-static {v3, v4, v5, v6, v7}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v3

    new-instance v4, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda9;

    invoke-direct {v4}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda9;-><init>()V

    invoke-static {v3, v4}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v3

    invoke-static {v3}, Lkotlin/sequences/SequencesKt;->toSet(Lkotlin/sequences/Sequence;)Ljava/util/Set;

    move-result-object v3

    .line 107
    nop

    .line 109
    .local v3, "presentes":Ljava/util/Set;
    sget-object v4, Lcom/twntool/editor/data/AvatarData;->INSTANCE:Lcom/twntool/editor/data/AvatarData;

    invoke-virtual {v4}, Lcom/twntool/editor/data/AvatarData;->getALL_KEYS()Ljava/util/List;

    move-result-object v4

    check-cast v4, Ljava/lang/Iterable;

    .local v4, "$this$filterNot$iv":Ljava/lang/Iterable;
    const/4 v8, 0x0

    .line 1523
    .local v8, "$i$f$filterNot":I
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    check-cast v9, Ljava/util/Collection;

    .local v9, "destination$iv$iv":Ljava/util/Collection;
    move-object v10, v4

    .local v10, "$this$filterNotTo$iv$iv":Ljava/lang/Iterable;
    const/4 v11, 0x0

    .line 1524
    .local v11, "$i$f$filterNotTo":I
    invoke-interface {v10}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v12

    :cond_54
    :goto_54
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_6c

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    .local v13, "element$iv$iv":Ljava/lang/Object;
    move-object v14, v13

    check-cast v14, Ljava/lang/String;

    .local v14, "it":Ljava/lang/String;
    const/4 v15, 0x0

    .line 109
    .local v15, "$i$a$-filterNot-XmlProcessor$unlockAvatars$faltando$1":I
    invoke-interface {v3, v14}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v14

    .line 1524
    .end local v14  # "it":Ljava/lang/String;
    .end local v15  # "$i$a$-filterNot-XmlProcessor$unlockAvatars$faltando$1":I
    if-nez v14, :cond_54

    invoke-interface {v9, v13}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_54

    .line 1525
    .end local v13  # "element$iv$iv":Ljava/lang/Object;
    :cond_6c
    nop

    .end local v9  # "destination$iv$iv":Ljava/util/Collection;
    .end local v10  # "$this$filterNotTo$iv$iv":Ljava/lang/Iterable;
    .end local v11  # "$i$f$filterNotTo":I
    check-cast v9, Ljava/util/List;

    .line 1523
    nop

    .end local v4  # "$this$filterNot$iv":Ljava/lang/Iterable;
    .end local v8  # "$i$f$filterNot":I
    check-cast v9, Ljava/lang/Iterable;

    .line 110
    move-object v4, v9

    .local v4, "$this$sortedBy$iv":Ljava/lang/Iterable;
    const/4 v8, 0x0

    .line 1526
    .local v8, "$i$f$sortedBy":I
    new-instance v9, Lcom/twntool/editor/core/XmlProcessor$unlockAvatars$$inlined$sortedBy$1;

    invoke-direct {v9}, Lcom/twntool/editor/core/XmlProcessor$unlockAvatars$$inlined$sortedBy$1;-><init>()V

    check-cast v9, Ljava/util/Comparator;

    invoke-static {v4, v9}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v4

    .line 110
    .end local v4  # "$this$sortedBy$iv":Ljava/lang/Iterable;
    .end local v8  # "$i$f$sortedBy":I
    nop

    .line 109
    nop

    .line 112
    .local v4, "faltando":Ljava/util/List;
    move-object v8, v4

    check-cast v8, Ljava/util/Collection;

    invoke-interface {v8}, Ljava/util/Collection;->isEmpty()Z

    move-result v8

    xor-int/lit8 v8, v8, 0x1

    if-eqz v8, :cond_15d

    .line 113
    move-object v9, v4

    check-cast v9, Ljava/lang/Iterable;

    sget-object v8, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    move-object v10, v8

    check-cast v10, Ljava/lang/CharSequence;

    new-instance v15, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda10;

    invoke-direct {v15}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda10;-><init>()V

    const/16 v16, 0x1e

    const/16 v17, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    invoke-static/range {v9 .. v17}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    .line 114
    .local v8, "novas":Ljava/lang/String;
    new-instance v9, Lkotlin/text/Regex;

    const-string v10, "</Global\\s*>"

    sget-object v11, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v9, v10, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v10, v2

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v9, v10, v5, v6, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    .line 115
    .local v9, "mG":Lkotlin/text/MatchResult;
    const-string v10, "substring(...)"

    if-eqz v9, :cond_f9

    .line 116
    invoke-interface {v9}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v2, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v6, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    invoke-interface {v9}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {v2, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_15c

    .line 118
    :cond_f9
    new-instance v11, Lkotlin/text/Regex;

    const-string v12, "</root\\s*>"

    sget-object v13, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v11, v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v12, v2

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v11, v12, v5, v6, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v6

    .line 119
    .local v6, "mR":Lkotlin/text/MatchResult;
    if-eqz v6, :cond_145

    .line 120
    invoke-interface {v6}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {v2, v5, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v7, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    invoke-interface {v6}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-virtual {v2, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_15c

    .line 121
    :cond_145
    sget-object v5, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 115
    .end local v6  # "mR":Lkotlin/text/MatchResult;
    :goto_15c
    move-object v2, v5

    .line 124
    .end local v8  # "novas":Ljava/lang/String;
    .end local v9  # "mG":Lkotlin/text/MatchResult;
    :cond_15d
    new-instance v5, Lkotlin/Triple;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    iget v7, v1, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-direct {v5, v2, v6, v7}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v5
.end method

.method public final unlockBuildingSkins(Ljava/lang/String;)Lkotlin/Pair;
    .registers 13
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 136
    nop

    .line 141
    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 129
    sget-object v0, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    .line 130
    sget-object v1, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v1}, Lcom/twntool/editor/data/SkinData;->getBUILDINGS_STASH_IDS()Ljava/util/List;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Ljava/lang/Iterable;

    sget-object v1, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    move-object v3, v1

    check-cast v3, Ljava/lang/CharSequence;

    new-instance v8, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda17;

    invoke-direct {v8}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda17;-><init>()V

    const/16 v9, 0x1e

    const/4 v10, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v2 .. v10}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 132
    sget-object v2, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<BuildingsStash>"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "</BuildingsStash>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 129
    nop

    .line 134
    .local v0, "novoBloco":Ljava/lang/String;
    new-instance v1, Lkotlin/text/Regex;

    .line 135
    const/4 v2, 0x2

    new-array v3, v2, [Lkotlin/text/RegexOption;

    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    sget-object v4, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    const/4 v6, 0x1

    aput-object v4, v3, v6

    invoke-static {v3}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v3

    .line 134
    const-string v4, "<BuildingsStash\\b[^/>]*>.*?</BuildingsStash\\s*>"

    invoke-direct {v1, v4, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Ljava/util/Set;)V

    .line 136
    .local v1, "rxFull":Lkotlin/text/Regex;
    move-object v3, p1

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    invoke-static {v1, v3, v5, v2, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    const-string v7, "substring(...)"

    if-eqz v3, :cond_b7

    move-object v2, v3

    .local v2, "it":Lkotlin/text/MatchResult;
    const/4 v3, 0x0

    .line 137
    .local v3, "$i$a$-let-XmlProcessor$unlockBuildingSkins$1":I
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 138
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v5

    add-int/2addr v5, v6

    invoke-virtual {p1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v5}, Lcom/twntool/editor/data/SkinData;->getBUILDINGS_STASH_IDS()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 137
    invoke-static {v4, v5}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4

    .line 140
    .end local v2  # "it":Lkotlin/text/MatchResult;
    .end local v3  # "$i$a$-let-XmlProcessor$unlockBuildingSkins$1":I
    :cond_b7
    new-instance v3, Lkotlin/text/Regex;

    const-string v8, "<BuildingsStash\\b[^>]*/\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v3, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 141
    .local v3, "rxSelf":Lkotlin/text/Regex;
    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v3, v8, v5, v2, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v8

    if-eqz v8, :cond_112

    move-object v2, v8

    .restart local v2  # "it":Lkotlin/text/MatchResult;
    const/4 v4, 0x0

    .line 142
    .local v4, "$i$a$-let-XmlProcessor$unlockBuildingSkins$2":I
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {p1, v5, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 143
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v8

    add-int/2addr v8, v6

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v6}, Lcom/twntool/editor/data/SkinData;->getBUILDINGS_STASH_IDS()Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 142
    invoke-static {v5, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v5

    return-object v5

    .line 145
    .end local v2  # "it":Lkotlin/text/MatchResult;
    .end local v4  # "$i$a$-let-XmlProcessor$unlockBuildingSkins$2":I
    :cond_112
    new-instance v6, Lkotlin/text/Regex;

    const-string v8, "</root\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v6, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v6, v8, v5, v2, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 146
    .local v2, "mRoot":Lkotlin/text/MatchResult;
    if-eqz v2, :cond_170

    .line 147
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v5, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    .line 148
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {p1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v5}, Lcom/twntool/editor/data/SkinData;->getBUILDINGS_STASH_IDS()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 147
    invoke-static {v4, v5}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    goto :goto_199

    .line 150
    :cond_170
    sget-object v4, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v5}, Lcom/twntool/editor/data/SkinData;->getBUILDINGS_STASH_IDS()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v4, v5}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    .line 146
    :goto_199
    return-object v4
.end method

.method public final unlockProfile(Ljava/lang/String;Ljava/util/Map;)Lkotlin/Pair;
    .registers 37
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "selection"  # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "+",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;>;)",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const-string v2, "xml"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 224
    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    .line 225
    .local v2, "novosPorCategoria":Ljava/util/LinkedHashMap;
    sget-object v3, Lcom/twntool/editor/data/ProfileData;->INSTANCE:Lcom/twntool/editor/data/ProfileData;

    invoke-virtual {v3}, Lcom/twntool/editor/data/ProfileData;->getALL()Ljava/util/LinkedHashMap;

    move-result-object v3

    check-cast v3, Ljava/util/Map;

    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_1e
    :goto_1e
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_9c

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    invoke-interface {v4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .local v6, "name":Ljava/lang/String;
    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/List;

    .line 226
    .local v4, "all":Ljava/util/List;
    if-nez v1, :cond_3a

    .line 228
    move-object v8, v4

    goto :goto_89

    .line 230
    :cond_3a
    invoke-interface {v1, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/List;

    .line 231
    .local v7, "v":Ljava/util/List;
    if-nez v7, :cond_47

    invoke-static {}, Lkotlin/collections/CollectionsKt;->emptyList()Ljava/util/List;

    move-result-object v8

    goto :goto_89

    .line 232
    :cond_47
    move-object v8, v7

    check-cast v8, Ljava/lang/Iterable;

    .local v8, "$this$mapNotNull$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 1527
    .local v9, "$i$f$mapNotNull":I
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    check-cast v10, Ljava/util/Collection;

    .local v10, "destination$iv$iv":Ljava/util/Collection;
    move-object v11, v8

    .local v11, "$this$mapNotNullTo$iv$iv":Ljava/lang/Iterable;
    const/4 v12, 0x0

    .line 1535
    .local v12, "$i$f$mapNotNullTo":I
    move-object v13, v11

    .local v13, "$this$forEach$iv$iv$iv":Ljava/lang/Iterable;
    const/4 v14, 0x0

    .line 1536
    .local v14, "$i$f$forEach":I
    invoke-interface {v13}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_5a
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_83

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    .local v16, "element$iv$iv$iv":Ljava/lang/Object;
    move-object/from16 v17, v16

    .local v17, "element$iv$iv":Ljava/lang/Object;
    const/16 v18, 0x0

    .line 1535
    .local v18, "$i$a$-forEach-CollectionsKt___CollectionsKt$mapNotNullTo$1$iv$iv":I
    move-object/from16 v19, v17

    check-cast v19, Ljava/lang/Number;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Number;->intValue()I

    move-result v5

    .local v5, "i":I
    const/16 v19, 0x0

    .line 232
    .local v19, "$i$a$-mapNotNull-XmlProcessor$unlockProfile$codigos$1":I
    invoke-static {v4, v5}, Lkotlin/collections/CollectionsKt;->getOrNull(Ljava/util/List;I)Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Ljava/lang/String;

    .line 1535
    .end local v5  # "i":I
    .end local v19  # "$i$a$-mapNotNull-XmlProcessor$unlockProfile$codigos$1":I
    if-eqz v21, :cond_81

    move-object/from16 v5, v21

    .line 1537
    .local v5, "it$iv$iv":Ljava/lang/Object;
    const/16 v19, 0x0

    .line 1535
    .local v19, "$i$a$-let-CollectionsKt___CollectionsKt$mapNotNullTo$1$1$iv$iv":I
    invoke-interface {v10, v5}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .line 1536
    .end local v5  # "it$iv$iv":Ljava/lang/Object;
    .end local v17  # "element$iv$iv":Ljava/lang/Object;
    .end local v18  # "$i$a$-forEach-CollectionsKt___CollectionsKt$mapNotNullTo$1$iv$iv":I
    .end local v19  # "$i$a$-let-CollectionsKt___CollectionsKt$mapNotNullTo$1$1$iv$iv":I
    :cond_81
    nop

    .end local v16  # "element$iv$iv$iv":Ljava/lang/Object;
    goto :goto_5a

    .line 1538
    :cond_83
    nop

    .line 1539
    .end local v13  # "$this$forEach$iv$iv$iv":Ljava/lang/Iterable;
    .end local v14  # "$i$f$forEach":I
    nop

    .end local v10  # "destination$iv$iv":Ljava/util/Collection;
    .end local v11  # "$this$mapNotNullTo$iv$iv":Ljava/lang/Iterable;
    .end local v12  # "$i$f$mapNotNullTo":I
    move-object v5, v10

    check-cast v5, Ljava/util/List;

    .line 1527
    move-object v8, v5

    .line 226
    .end local v7  # "v":Ljava/util/List;
    .end local v8  # "$this$mapNotNull$iv":Ljava/lang/Iterable;
    .end local v9  # "$i$f$mapNotNull":I
    :goto_89
    move-object v5, v8

    .line 234
    .local v5, "codigos":Ljava/util/List;
    move-object v7, v5

    check-cast v7, Ljava/util/Collection;

    invoke-interface {v7}, Ljava/util/Collection;->isEmpty()Z

    move-result v7

    const/4 v8, 0x1

    xor-int/2addr v7, v8

    if-eqz v7, :cond_1e

    move-object v7, v2

    check-cast v7, Ljava/util/Map;

    invoke-interface {v7, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1e

    .line 236
    .end local v4  # "all":Ljava/util/List;
    .end local v5  # "codigos":Ljava/util/List;
    .end local v6  # "name":Ljava/lang/String;
    :cond_9c
    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->isEmpty()Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_b8

    sget-object v3, Lcom/twntool/editor/data/Strings;->INSTANCE:Lcom/twntool/editor/data/Strings;

    sget-object v5, Lcom/twntool/editor/data/AppState;->INSTANCE:Lcom/twntool/editor/data/AppState;

    invoke-virtual {v5}, Lcom/twntool/editor/data/AppState;->getLang()Ljava/lang/String;

    move-result-object v5

    const-string v6, "sel_none"

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v3, v5, v6, v4}, Lcom/twntool/editor/data/Strings;->t(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 238
    :cond_b8
    move-object/from16 v3, p1

    .line 239
    .local v3, "out":Ljava/lang/String;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    check-cast v5, Ljava/util/List;

    .line 242
    .local v5, "ok":Ljava/util/List;
    move-object v6, v2

    check-cast v6, Ljava/util/Map;

    invoke-interface {v6}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_cc
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    const/4 v8, 0x0

    const/4 v9, 0x2

    const-string v10, "substring(...)"

    if-eqz v7, :cond_26f

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Map$Entry;

    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .local v11, "name":Ljava/lang/String;
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/List;

    .line 243
    .local v7, "codigosNovos":Ljava/util/List;
    new-instance v12, Lkotlin/text/Regex;

    .line 244
    sget-object v13, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v13, v11}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "<DataElem\\b[^>]*\\bname=\""

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\"[^>]*/>"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 245
    sget-object v14, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    .line 243
    invoke-direct {v12, v13, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 247
    .local v12, "rx":Lkotlin/text/Regex;
    move-object v13, v3

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v12, v13, v4, v9, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v13

    if-nez v13, :cond_118

    goto :goto_cc

    .line 249
    .local v13, "m":Lkotlin/text/MatchResult;
    :cond_118
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v14

    .line 250
    .local v14, "tagExistente":Ljava/lang/String;
    new-instance v15, Lkotlin/text/Regex;

    const-string v4, "\\bvalue\\s*=\\s*\"([^\"]*)\""

    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v15, v4, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v4, v14

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v0, 0x0

    const/4 v8, 0x0

    invoke-static {v15, v4, v0, v9, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 251
    .local v4, "mVal":Lkotlin/text/MatchResult;
    nop

    .line 252
    nop

    .line 251
    const-string v0, ","

    if-eqz v4, :cond_1e1

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v8

    if-eqz v8, :cond_1e1

    const/4 v9, 0x1

    invoke-interface {v8, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    if-eqz v8, :cond_1e1

    move-object/from16 v21, v8

    check-cast v21, Ljava/lang/CharSequence;

    new-array v8, v9, [Ljava/lang/String;

    const/4 v9, 0x0

    aput-object v0, v8, v9

    const/16 v25, 0x6

    const/16 v26, 0x0

    const/16 v23, 0x0

    const/16 v24, 0x0

    move-object/from16 v22, v8

    invoke-static/range {v21 .. v26}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v8

    .line 252
    if-eqz v8, :cond_1de

    .line 251
    check-cast v8, Ljava/lang/Iterable;

    .line 252
    nop

    .local v8, "$this$map$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 1540
    .local v9, "$i$f$map":I
    new-instance v15, Ljava/util/ArrayList;

    const/16 v1, 0xa

    invoke-static {v8, v1}, Lkotlin/collections/CollectionsKt;->collectionSizeOrDefault(Ljava/lang/Iterable;I)I

    move-result v1

    invoke-direct {v15, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v1, v15

    check-cast v1, Ljava/util/Collection;

    .local v1, "destination$iv$iv":Ljava/util/Collection;
    move-object v15, v8

    .local v15, "$this$mapTo$iv$iv":Ljava/lang/Iterable;
    const/16 v17, 0x0

    .line 1541
    .local v17, "$i$f$mapTo":I
    invoke-interface {v15}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v18

    :goto_175
    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-eqz v19, :cond_199

    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v19

    .line 1542
    .local v19, "item$iv$iv":Ljava/lang/Object;
    move-object/from16 v21, v19

    check-cast v21, Ljava/lang/String;

    .local v21, "it":Ljava/lang/String;
    const/16 v22, 0x0

    .line 252
    .local v22, "$i$a$-map-XmlProcessor$unlockProfile$existentes$1":I
    move-object/from16 v23, v21

    check-cast v23, Ljava/lang/CharSequence;

    invoke-static/range {v23 .. v23}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v23

    move-object/from16 v24, v4

    .end local v4  # "mVal":Lkotlin/text/MatchResult;
    .local v24, "mVal":Lkotlin/text/MatchResult;
    invoke-virtual/range {v23 .. v23}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1542
    .end local v21  # "it":Ljava/lang/String;
    .end local v22  # "$i$a$-map-XmlProcessor$unlockProfile$existentes$1":I
    invoke-interface {v1, v4}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    move-object/from16 v4, v24

    goto :goto_175

    .line 1543
    .end local v19  # "item$iv$iv":Ljava/lang/Object;
    .end local v24  # "mVal":Lkotlin/text/MatchResult;
    .restart local v4  # "mVal":Lkotlin/text/MatchResult;
    :cond_199
    move-object/from16 v24, v4

    .end local v1  # "destination$iv$iv":Ljava/util/Collection;
    .end local v4  # "mVal":Lkotlin/text/MatchResult;
    .end local v15  # "$this$mapTo$iv$iv":Ljava/lang/Iterable;
    .end local v17  # "$i$f$mapTo":I
    .restart local v24  # "mVal":Lkotlin/text/MatchResult;
    check-cast v1, Ljava/util/List;

    .line 1540
    nop

    .line 252
    .end local v8  # "$this$map$iv":Ljava/lang/Iterable;
    .end local v9  # "$i$f$map":I
    nop

    .line 251
    check-cast v1, Ljava/lang/Iterable;

    .line 252
    nop

    .local v1, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 1544
    .local v4, "$i$f$filter":I
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    check-cast v8, Ljava/util/Collection;

    .local v8, "destination$iv$iv":Ljava/util/Collection;
    move-object v9, v1

    .local v9, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v15, 0x0

    .line 1545
    .local v15, "$i$f$filterTo":I
    invoke-interface {v9}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v17

    :goto_1b0
    invoke-interface/range {v17 .. v17}, Ljava/util/Iterator;->hasNext()Z

    move-result v18

    if-eqz v18, :cond_1d6

    move-object/from16 v18, v1

    .end local v1  # "$this$filter$iv":Ljava/lang/Iterable;
    .local v18, "$this$filter$iv":Ljava/lang/Iterable;
    invoke-interface/range {v17 .. v17}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .local v1, "element$iv$iv":Ljava/lang/Object;
    move-object/from16 v19, v1

    check-cast v19, Ljava/lang/String;

    .local v19, "it":Ljava/lang/String;
    const/16 v21, 0x0

    .line 252
    .local v21, "$i$a$-filter-XmlProcessor$unlockProfile$existentes$2":I
    move-object/from16 v22, v19

    check-cast v22, Ljava/lang/CharSequence;

    invoke-static/range {v22 .. v22}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v22

    const/16 v20, 0x1

    xor-int/lit8 v22, v22, 0x1

    .line 1545
    .end local v19  # "it":Ljava/lang/String;
    .end local v21  # "$i$a$-filter-XmlProcessor$unlockProfile$existentes$2":I
    if-eqz v22, :cond_1d3

    invoke-interface {v8, v1}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    :cond_1d3
    move-object/from16 v1, v18

    goto :goto_1b0

    .line 1546
    .end local v18  # "$this$filter$iv":Ljava/lang/Iterable;
    .local v1, "$this$filter$iv":Ljava/lang/Iterable;
    :cond_1d6
    move-object/from16 v18, v1

    .end local v1  # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v8  # "destination$iv$iv":Ljava/util/Collection;
    .end local v9  # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v15  # "$i$f$filterTo":I
    .restart local v18  # "$this$filter$iv":Ljava/lang/Iterable;
    move-object v1, v8

    check-cast v1, Ljava/util/List;

    .line 1544
    nop

    .line 252
    .end local v4  # "$i$f$filter":I
    .end local v18  # "$this$filter$iv":Ljava/lang/Iterable;
    nop

    .line 251
    goto :goto_1e7

    .line 252
    .end local v24  # "mVal":Lkotlin/text/MatchResult;
    .local v4, "mVal":Lkotlin/text/MatchResult;
    :cond_1de
    move-object/from16 v24, v4

    .end local v4  # "mVal":Lkotlin/text/MatchResult;
    .restart local v24  # "mVal":Lkotlin/text/MatchResult;
    goto :goto_1e3

    .line 251
    .end local v24  # "mVal":Lkotlin/text/MatchResult;
    .restart local v4  # "mVal":Lkotlin/text/MatchResult;
    :cond_1e1
    move-object/from16 v24, v4

    .line 252
    .end local v4  # "mVal":Lkotlin/text/MatchResult;
    .restart local v24  # "mVal":Lkotlin/text/MatchResult;
    :goto_1e3
    invoke-static {}, Lkotlin/collections/CollectionsKt;->emptyList()Ljava/util/List;

    move-result-object v1

    .line 251
    :goto_1e7
    nop

    .line 254
    .local v1, "existentes":Ljava/util/List;
    move-object v4, v1

    check-cast v4, Ljava/util/Collection;

    invoke-static {v4}, Lkotlin/collections/CollectionsKt;->toMutableList(Ljava/util/Collection;)Ljava/util/List;

    move-result-object v4

    .line 255
    .local v4, "merged":Ljava/util/List;
    const/4 v8, 0x0

    .line 256
    .local v8, "adicionou":Z
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :cond_1f4
    :goto_1f4
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-eqz v15, :cond_20b

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 257
    .local v15, "c":Ljava/lang/String;
    invoke-interface {v4, v15}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v17

    if-nez v17, :cond_1f4

    invoke-interface {v4, v15}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v8, 0x1

    .end local v15  # "c":Ljava/lang/String;
    goto :goto_1f4

    .line 259
    :cond_20b
    if-eqz v8, :cond_265

    .line 260
    sget-object v9, Lcom/twntool/editor/data/ProfileData;->INSTANCE:Lcom/twntool/editor/data/ProfileData;

    move-object/from16 v25, v4

    check-cast v25, Ljava/lang/Iterable;

    move-object/from16 v26, v0

    check-cast v26, Ljava/lang/CharSequence;

    const/16 v32, 0x3e

    const/16 v33, 0x0

    const/16 v27, 0x0

    const/16 v28, 0x0

    const/16 v29, 0x0

    const/16 v30, 0x0

    const/16 v31, 0x0

    invoke-static/range {v25 .. v33}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v9, v11, v0}, Lcom/twntool/editor/data/ProfileData;->dataElemTag(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 261
    .local v0, "novoTag":Ljava/lang/String;
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v9

    const/4 v15, 0x0

    invoke-virtual {v3, v15, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v13}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v15

    const/16 v17, 0x1

    add-int/lit8 v15, v15, 0x1

    invoke-virtual {v3, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 263
    .end local v0  # "novoTag":Ljava/lang/String;
    :cond_265
    invoke-interface {v5, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const/4 v4, 0x0

    .end local v1  # "existentes":Ljava/util/List;
    .end local v4  # "merged":Ljava/util/List;
    .end local v8  # "adicionou":Z
    .end local v12  # "rx":Lkotlin/text/Regex;
    .end local v13  # "m":Lkotlin/text/MatchResult;
    .end local v14  # "tagExistente":Ljava/lang/String;
    .end local v24  # "mVal":Lkotlin/text/MatchResult;
    goto/16 :goto_cc

    .line 267
    .end local v7  # "codigosNovos":Ljava/util/List;
    .end local v11  # "name":Ljava/lang/String;
    :cond_26f
    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    const-string v1, "<get-keys>(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 1547
    .local v4, "$i$f$filter":I
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    check-cast v6, Ljava/util/Collection;

    .local v6, "destination$iv$iv":Ljava/util/Collection;
    move-object v7, v0

    .local v7, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v8, 0x0

    .line 1548
    .local v8, "$i$f$filterTo":I
    invoke-interface {v7}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :cond_288
    :goto_288
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_2a3

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    .local v12, "element$iv$iv":Ljava/lang/Object;
    move-object v13, v12

    check-cast v13, Ljava/lang/String;

    .local v13, "it":Ljava/lang/String;
    const/4 v14, 0x0

    .line 267
    .local v14, "$i$a$-filter-XmlProcessor$unlockProfile$missing$1":I
    invoke-interface {v5, v13}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v15

    const/4 v13, 0x1

    .line 1548
    .end local v13  # "it":Ljava/lang/String;
    .end local v14  # "$i$a$-filter-XmlProcessor$unlockProfile$missing$1":I
    xor-int/lit8 v14, v15, 0x1

    if-eqz v14, :cond_288

    invoke-interface {v6, v12}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_288

    .line 1549
    .end local v12  # "element$iv$iv":Ljava/lang/Object;
    :cond_2a3
    nop

    .end local v6  # "destination$iv$iv":Ljava/util/Collection;
    .end local v7  # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v8  # "$i$f$filterTo":I
    check-cast v6, Ljava/util/List;

    .line 1547
    nop

    .line 267
    .end local v0  # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v4  # "$i$f$filter":I
    move-object v0, v6

    .line 268
    .local v0, "missing":Ljava/util/List;
    move-object v4, v0

    check-cast v4, Ljava/util/Collection;

    invoke-interface {v4}, Ljava/util/Collection;->isEmpty()Z

    move-result v4

    const/4 v6, 0x1

    xor-int/2addr v4, v6

    if-eqz v4, :cond_422

    .line 269
    new-instance v4, Lkotlin/text/Regex;

    .line 270
    sget-object v6, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    .line 269
    const-string v7, "<DataElem\\b[^>]*\\bname=\"PlayerProfile\"[^>]*>"

    invoke-direct {v4, v7, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 270
    move-object v6, v3

    check-cast v6, Ljava/lang/CharSequence;

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static {v4, v6, v8, v9, v7}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 269
    nop

    .line 271
    .local v4, "mPP":Lkotlin/text/MatchResult;
    if-eqz v4, :cond_36b

    .line 272
    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v6

    const/4 v7, 0x1

    add-int/2addr v6, v7

    .line 273
    .local v6, "searchFrom":I
    new-instance v7, Lkotlin/text/Regex;

    .line 274
    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    .line 273
    const-string v11, "<DataElem\\b[^>]*\\bname=\"Configs\"[^>]*>"

    invoke-direct {v7, v11, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 274
    move-object v8, v3

    check-cast v8, Ljava/lang/CharSequence;

    invoke-virtual {v7, v8, v6}, Lkotlin/text/Regex;->find(Ljava/lang/CharSequence;I)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 273
    nop

    .line 275
    .local v7, "mCfg":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_36b

    .line 276
    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v8

    const/4 v11, 0x1

    add-int/2addr v8, v11

    .line 277
    .local v8, "absCfgEnd":I
    new-instance v11, Lkotlin/text/Regex;

    const-string v12, "</DataElem\\s*>"

    sget-object v13, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v11, v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v12, v3

    check-cast v12, Ljava/lang/CharSequence;

    invoke-virtual {v11, v12, v8}, Lkotlin/text/Regex;->find(Ljava/lang/CharSequence;I)Lkotlin/text/MatchResult;

    move-result-object v11

    .line 278
    .local v11, "mClose":Lkotlin/text/MatchResult;
    if-eqz v11, :cond_36b

    .line 279
    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v12

    .line 280
    .local v12, "insertPos":I
    move-object/from16 v21, v0

    check-cast v21, Ljava/lang/Iterable;

    const-string v13, "\n          "

    move-object/from16 v22, v13

    check-cast v22, Ljava/lang/CharSequence;

    new-instance v14, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda4;

    invoke-direct {v14, v2}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda4;-><init>(Ljava/util/LinkedHashMap;)V

    const/16 v28, 0x1e

    const/16 v29, 0x0

    const/16 v23, 0x0

    const/16 v24, 0x0

    const/16 v25, 0x0

    const/16 v26, 0x0

    move-object/from16 v27, v14

    invoke-static/range {v21 .. v29}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n        "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 283
    .local v13, "insertStr":Ljava/lang/String;
    const/4 v14, 0x0

    invoke-virtual {v3, v14, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 284
    move-object v9, v0

    check-cast v9, Ljava/util/Collection;

    invoke-interface {v5, v9}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 289
    .end local v6  # "searchFrom":I
    .end local v7  # "mCfg":Lkotlin/text/MatchResult;
    .end local v8  # "absCfgEnd":I
    .end local v11  # "mClose":Lkotlin/text/MatchResult;
    .end local v12  # "insertPos":I
    .end local v13  # "insertStr":Ljava/lang/String;
    :cond_36b
    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->keySet()Ljava/util/Set;

    move-result-object v6

    invoke-static {v6, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v1, v6

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 1550
    .local v6, "$i$f$filter":I
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    check-cast v7, Ljava/util/Collection;

    .local v7, "destination$iv$iv":Ljava/util/Collection;
    move-object v8, v1

    .local v8, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 1551
    .local v9, "$i$f$filterTo":I
    invoke-interface {v8}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :cond_383
    :goto_383
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_39e

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    .local v12, "element$iv$iv":Ljava/lang/Object;
    move-object v13, v12

    check-cast v13, Ljava/lang/String;

    .local v13, "it":Ljava/lang/String;
    const/4 v14, 0x0

    .line 289
    .local v14, "$i$a$-filter-XmlProcessor$unlockProfile$stillMissing$1":I
    invoke-interface {v5, v13}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v15

    const/4 v13, 0x1

    .line 1551
    .end local v13  # "it":Ljava/lang/String;
    .end local v14  # "$i$a$-filter-XmlProcessor$unlockProfile$stillMissing$1":I
    xor-int/lit8 v14, v15, 0x1

    if-eqz v14, :cond_383

    invoke-interface {v7, v12}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_383

    .line 1552
    .end local v12  # "element$iv$iv":Ljava/lang/Object;
    :cond_39e
    nop

    .end local v7  # "destination$iv$iv":Ljava/util/Collection;
    .end local v8  # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v9  # "$i$f$filterTo":I
    check-cast v7, Ljava/util/List;

    .line 1550
    nop

    .line 289
    .end local v1  # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v6  # "$i$f$filter":I
    move-object v1, v7

    .line 290
    .local v1, "stillMissing":Ljava/util/List;
    move-object v6, v1

    check-cast v6, Ljava/util/Collection;

    invoke-interface {v6}, Ljava/util/Collection;->isEmpty()Z

    move-result v6

    const/4 v7, 0x1

    xor-int/2addr v6, v7

    if-eqz v6, :cond_422

    .line 291
    new-instance v6, Lkotlin/text/Regex;

    const-string v7, "</root\\s*>"

    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v6, v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v7, v3

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v8, 0x0

    const/4 v9, 0x2

    const/4 v11, 0x0

    invoke-static {v6, v7, v11, v9, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v6

    .line 292
    .local v6, "mRoot":Lkotlin/text/MatchResult;
    if-eqz v6, :cond_422

    .line 293
    move-object/from16 v17, v1

    check-cast v17, Ljava/lang/Iterable;

    const-string v7, "\n"

    move-object/from16 v18, v7

    check-cast v18, Ljava/lang/CharSequence;

    new-instance v8, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda5;

    invoke-direct {v8, v2}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda5;-><init>(Ljava/util/LinkedHashMap;)V

    const/16 v24, 0x1e

    const/16 v25, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    const/16 v21, 0x0

    const/16 v22, 0x0

    move-object/from16 v23, v8

    invoke-static/range {v17 .. v25}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    .line 296
    .local v8, "tags":Ljava/lang/String;
    invoke-interface {v6}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v9

    const/4 v11, 0x0

    invoke-virtual {v3, v11, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v6}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-virtual {v3, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 297
    move-object v7, v1

    check-cast v7, Ljava/util/Collection;

    invoke-interface {v5, v7}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 302
    .end local v1  # "stillMissing":Ljava/util/List;
    .end local v4  # "mPP":Lkotlin/text/MatchResult;
    .end local v6  # "mRoot":Lkotlin/text/MatchResult;
    .end local v8  # "tags":Ljava/lang/String;
    :cond_422
    move-object v6, v5

    check-cast v6, Ljava/lang/Iterable;

    const-string v1, ", "

    move-object v7, v1

    check-cast v7, Ljava/lang/CharSequence;

    new-instance v12, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda6;

    invoke-direct {v12, v2}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda6;-><init>(Ljava/util/LinkedHashMap;)V

    const/16 v13, 0x1e

    const/4 v14, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-static/range {v6 .. v14}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 313
    .local v1, "resumo":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "✔ Perfil: "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4
.end method

.method public final unlockStickers(Ljava/lang/String;)Lkotlin/Pair;
    .registers 18
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-string v2, "xml"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 186
    new-instance v2, Lkotlin/text/Regex;

    .line 187
    nop

    .line 188
    const/4 v3, 0x2

    new-array v4, v3, [Lkotlin/text/RegexOption;

    sget-object v5, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    sget-object v5, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    const/4 v7, 0x1

    aput-object v5, v4, v7

    invoke-static {v4}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v4

    .line 186
    const-string v5, "<FragmentedBeautyManager\\b[^/>]*>.*?</FragmentedBeautyManager\\s*>"

    invoke-direct {v2, v5, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Ljava/util/Set;)V

    .line 190
    .local v2, "rxFull":Lkotlin/text/Regex;
    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    invoke-static {v2, v4, v6, v3, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    const-string v8, "substring(...)"

    if-eqz v4, :cond_6b

    .local v4, "it":Lkotlin/text/MatchResult;
    const/4 v9, 0x0

    .line 191
    .local v9, "$i$a$-let-XmlProcessor$unlockStickers$out$1":I
    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    invoke-virtual {v1, v6, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v11, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v11}, Lcom/twntool/editor/data/SkinData;->getSTICKERS_BLOCK()Ljava/lang/String;

    move-result-object v11

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v12

    add-int/2addr v12, v7

    invoke-virtual {v1, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 190
    .end local v4  # "it":Lkotlin/text/MatchResult;
    .end local v9  # "$i$a$-let-XmlProcessor$unlockStickers$out$1":I
    if-nez v10, :cond_135

    .line 192
    :cond_6b
    move-object v4, v0

    check-cast v4, Lcom/twntool/editor/core/XmlProcessor;

    .local v4, "$this$unlockStickers_u24lambda_u2417":Lcom/twntool/editor/core/XmlProcessor;
    const/4 v9, 0x0

    .line 193
    .local v9, "$i$a$-run-XmlProcessor$unlockStickers$out$2":I
    new-instance v10, Lkotlin/text/Regex;

    const-string v11, "<FragmentedBeautyManager\\b[^>]*/\\s*>"

    sget-object v12, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v10, v11, v12}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 194
    .local v10, "rxSelf":Lkotlin/text/Regex;
    move-object v11, v1

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v10, v11, v6, v3, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v11

    if-eqz v11, :cond_c1

    .local v11, "it":Lkotlin/text/MatchResult;
    const/4 v12, 0x0

    .line 195
    .local v12, "$i$a$-let-XmlProcessor$unlockStickers$out$2$1":I
    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v13

    invoke-virtual {v13}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v13

    invoke-virtual {v1, v6, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v14, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v14}, Lcom/twntool/editor/data/SkinData;->getSTICKERS_BLOCK()Ljava/lang/String;

    move-result-object v14

    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v15

    add-int/2addr v15, v7

    invoke-virtual {v1, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 194
    .end local v11  # "it":Lkotlin/text/MatchResult;
    .end local v12  # "$i$a$-let-XmlProcessor$unlockStickers$out$2$1":I
    if-nez v7, :cond_bf

    goto :goto_c1

    :cond_bf
    move-object v5, v7

    goto :goto_133

    .line 196
    :cond_c1
    :goto_c1
    move-object v7, v4

    .local v7, "$this$unlockStickers_u24lambda_u2417_u24lambda_u2416":Lcom/twntool/editor/core/XmlProcessor;
    const/4 v11, 0x0

    .line 197
    .local v11, "$i$a$-run-XmlProcessor$unlockStickers$out$2$2":I
    new-instance v12, Lkotlin/text/Regex;

    const-string v13, "</root\\s*>"

    sget-object v14, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v12, v13, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v13, v1

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v12, v13, v6, v3, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 198
    .local v3, "mRoot":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_115

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {v1, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v6, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v6}, Lcom/twntool/editor/data/SkinData;->getSTICKERS_BLOCK()Ljava/lang/String;

    move-result-object v6

    sget-object v12, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    .line 199
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v13

    invoke-virtual {v13}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v13

    invoke-virtual {v1, v13}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_132

    .line 200
    :cond_115
    sget-object v5, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    sget-object v6, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v6}, Lcom/twntool/editor/data/SkinData;->getSTICKERS_BLOCK()Ljava/lang/String;

    move-result-object v6

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 196
    .end local v3  # "mRoot":Lkotlin/text/MatchResult;
    .end local v7  # "$this$unlockStickers_u24lambda_u2417_u24lambda_u2416":Lcom/twntool/editor/core/XmlProcessor;
    .end local v11  # "$i$a$-run-XmlProcessor$unlockStickers$out$2$2":I
    :goto_132
    nop

    .line 201
    :goto_133
    nop

    .line 192
    .end local v4  # "$this$unlockStickers_u24lambda_u2417":Lcom/twntool/editor/core/XmlProcessor;
    .end local v9  # "$i$a$-run-XmlProcessor$unlockStickers$out$2":I
    .end local v10  # "rxSelf":Lkotlin/text/Regex;
    move-object v10, v5

    .line 190
    :cond_135
    move-object v3, v10

    .line 203
    .local v3, "out":Ljava/lang/String;
    invoke-direct {v0, v3}, Lcom/twntool/editor/core/XmlProcessor;->applyChatEmoji(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 204
    const/4 v4, 0x1

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-static {v3, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4
.end method

.method public final unlockTerrenos(Ljava/lang/String;)Lkotlin/Pair;
    .registers 26
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    const-string v1, "xml"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1322
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v6, 0x6

    const/4 v7, 0x0

    const-string v3, "<TownGround"

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v1

    .line 1323
    .local v1, "tgStart":I
    const/4 v2, -0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    if-ne v1, v2, :cond_20

    invoke-static {v0, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 1325
    :cond_20
    move-object v8, v0

    check-cast v8, Ljava/lang/CharSequence;

    const/4 v12, 0x4

    const/4 v13, 0x0

    const-string v9, "</TownGround>"

    const/4 v11, 0x0

    move v10, v1

    invoke-static/range {v8 .. v13}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v4

    .line 1326
    .local v4, "tgEndIdx":I
    if-ne v4, v2, :cond_34

    invoke-static {v0, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    return-object v2

    .line 1327
    :cond_34
    add-int/lit8 v3, v4, 0xd

    .line 1329
    .local v3, "tgEnd":I
    invoke-virtual {v0, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v6, "substring(...)"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1331
    .local v5, "tgBloco":Ljava/lang/String;
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "d=\"([^\"]+)\""

    invoke-direct {v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v5

    check-cast v8, Ljava/lang/CharSequence;

    new-instance v9, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda16;

    invoke-direct {v9}, Lcom/twntool/editor/core/XmlProcessor$$ExternalSyntheticLambda16;-><init>()V

    invoke-virtual {v7, v8, v9}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v7

    .line 1335
    .local v7, "tgDesbloqueado":Ljava/lang/String;
    const/4 v8, 0x0

    invoke-virtual {v0, v8, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 1338
    .local v9, "out":Ljava/lang/String;
    new-instance v10, Lkotlin/text/Regex;

    const-string v11, "<Object\\b[^>]*expandBuy[^>]*/>\\s*\\n?"

    invoke-direct {v10, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1339
    .local v10, "padrao":Lkotlin/text/Regex;
    const/4 v11, 0x0

    .line 1341
    .local v11, "nTotal":I
    new-instance v12, Lkotlin/text/Regex;

    const-string v13, "<Buildings\\b"

    invoke-direct {v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v13, v9

    check-cast v13, Ljava/lang/CharSequence;

    const/4 v14, 0x2

    const/4 v15, 0x0

    invoke-static {v12, v13, v8, v14, v15}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v12

    invoke-static {v12}, Lkotlin/sequences/SequencesKt;->toList(Lkotlin/sequences/Sequence;)Ljava/util/List;

    move-result-object v12

    check-cast v12, Ljava/lang/Iterable;

    invoke-static {v12}, Lkotlin/collections/CollectionsKt;->reversed(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v12

    .line 1342
    .local v12, "bldStarts":Ljava/util/List;
    invoke-interface {v12}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_9c
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_158

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lkotlin/text/MatchResult;

    .line 1343
    .local v16, "m":Lkotlin/text/MatchResult;
    invoke-interface/range {v16 .. v16}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    .line 1344
    .local v8, "bldStart":I
    move-object/from16 v18, v9

    check-cast v18, Ljava/lang/CharSequence;

    const/16 v22, 0x4

    const/16 v23, 0x0

    const-string v19, "</Buildings>"

    const/16 v21, 0x0

    move/from16 v20, v8

    invoke-static/range {v18 .. v23}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v14

    .line 1345
    .local v14, "bldEndIdx":I
    if-eq v14, v2, :cond_140

    .line 1346
    add-int/lit8 v2, v14, 0xc

    .line 1347
    .local v2, "bldEnd":I
    invoke-virtual {v9, v8, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1348
    .local v15, "bldBlock":Ljava/lang/String;
    move-object v0, v15

    check-cast v0, Ljava/lang/CharSequence;

    const-string v20, "expandBuy"

    move/from16 v21, v1

    .end local v1  # "tgStart":I
    .local v21, "tgStart":I
    move-object/from16 v1, v20

    check-cast v1, Ljava/lang/CharSequence;

    move/from16 v20, v3

    move/from16 v17, v4

    move-object/from16 v19, v5

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    .end local v3  # "tgEnd":I
    .end local v4  # "tgEndIdx":I
    .end local v5  # "tgBloco":Ljava/lang/String;
    .local v17, "tgEndIdx":I
    .local v19, "tgBloco":Ljava/lang/String;
    .local v20, "tgEnd":I
    invoke-static {v0, v1, v5, v4, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_148

    .line 1349
    move-object v0, v15

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v10, v0, v5, v4, v3}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v0

    invoke-static {v0}, Lkotlin/sequences/SequencesKt;->count(Lkotlin/sequences/Sequence;)I

    move-result v0

    .line 1350
    .local v0, "before":I
    move-object v1, v15

    check-cast v1, Ljava/lang/CharSequence;

    const-string v5, ""

    invoke-virtual {v10, v1, v5}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1351
    .local v1, "bldLimpo":Ljava/lang/String;
    new-instance v5, Lkotlin/text/Regex;

    const-string v3, "\\n\\s*\\n"

    invoke-direct {v5, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v1

    check-cast v3, Ljava/lang/CharSequence;

    const-string v4, "\n"

    invoke-virtual {v5, v3, v4}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1352
    const/4 v3, 0x0

    invoke-virtual {v9, v3, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v9, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 1353
    add-int/2addr v11, v0

    move-object/from16 v0, p1

    move/from16 v4, v17

    move-object/from16 v5, v19

    move/from16 v3, v20

    move/from16 v1, v21

    const/4 v2, -0x1

    const/4 v8, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    .end local v0  # "before":I
    .end local v1  # "bldLimpo":Ljava/lang/String;
    .end local v2  # "bldEnd":I
    .end local v8  # "bldStart":I
    .end local v14  # "bldEndIdx":I
    .end local v15  # "bldBlock":Ljava/lang/String;
    .end local v16  # "m":Lkotlin/text/MatchResult;
    goto/16 :goto_9c

    .line 1345
    .end local v17  # "tgEndIdx":I
    .end local v19  # "tgBloco":Ljava/lang/String;
    .end local v20  # "tgEnd":I
    .end local v21  # "tgStart":I
    .local v1, "tgStart":I
    .restart local v3  # "tgEnd":I
    .restart local v4  # "tgEndIdx":I
    .restart local v5  # "tgBloco":Ljava/lang/String;
    .restart local v8  # "bldStart":I
    .restart local v14  # "bldEndIdx":I
    .restart local v16  # "m":Lkotlin/text/MatchResult;
    :cond_140
    move/from16 v21, v1

    move/from16 v20, v3

    move/from16 v17, v4

    move-object/from16 v19, v5

    .line 1342
    .end local v1  # "tgStart":I
    .end local v3  # "tgEnd":I
    .end local v4  # "tgEndIdx":I
    .end local v5  # "tgBloco":Ljava/lang/String;
    .end local v8  # "bldStart":I
    .end local v14  # "bldEndIdx":I
    .end local v16  # "m":Lkotlin/text/MatchResult;
    .restart local v17  # "tgEndIdx":I
    .restart local v19  # "tgBloco":Ljava/lang/String;
    .restart local v20  # "tgEnd":I
    .restart local v21  # "tgStart":I
    :cond_148
    move-object/from16 v0, p1

    move/from16 v4, v17

    move-object/from16 v5, v19

    move/from16 v3, v20

    move/from16 v1, v21

    const/4 v2, -0x1

    const/4 v8, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    goto/16 :goto_9c

    .line 1355
    .end local v17  # "tgEndIdx":I
    .end local v19  # "tgBloco":Ljava/lang/String;
    .end local v20  # "tgEnd":I
    .end local v21  # "tgStart":I
    .restart local v1  # "tgStart":I
    .restart local v3  # "tgEnd":I
    .restart local v4  # "tgEndIdx":I
    .restart local v5  # "tgBloco":Ljava/lang/String;
    :cond_158
    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v9, v0}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    return-object v0
.end method

.method public final unlockVehicleSkins(Ljava/lang/String;)Lkotlin/Pair;
    .registers 12
    .param p1, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .line 157
    nop

    .line 162
    const-string v0, "xml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 155
    new-instance v0, Lkotlin/text/Regex;

    .line 156
    const/4 v1, 0x2

    new-array v2, v1, [Lkotlin/text/RegexOption;

    sget-object v3, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    const/4 v5, 0x1

    .line 159
    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    .line 156
    aput-object v3, v2, v5

    invoke-static {v2}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v2

    .line 155
    const-string v3, "<Skins\\b[^/>]*>.*?</Skins\\s*>"

    invoke-direct {v0, v3, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Ljava/util/Set;)V

    .line 157
    .local v0, "rxFull":Lkotlin/text/Regex;
    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    invoke-static {v0, v2, v4, v1, v3}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    const-string v7, "substring(...)"

    if-eqz v2, :cond_6f

    move-object v1, v2

    .local v1, "it":Lkotlin/text/MatchResult;
    const/4 v2, 0x0

    .line 158
    .local v2, "$i$a$-let-XmlProcessor$unlockVehicleSkins$1":I
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    invoke-virtual {p1, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v4, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v4}, Lcom/twntool/editor/data/SkinData;->getSKINS_BLOCK()Ljava/lang/String;

    move-result-object v4

    .line 159
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v8

    add-int/2addr v8, v5

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 158
    invoke-static {v3, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 161
    .end local v1  # "it":Lkotlin/text/MatchResult;
    .end local v2  # "$i$a$-let-XmlProcessor$unlockVehicleSkins$1":I
    :cond_6f
    new-instance v2, Lkotlin/text/Regex;

    const-string v8, "<Skins\\b[^>]*/\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v2, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 162
    .local v2, "rxSelf":Lkotlin/text/Regex;
    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v2, v8, v4, v1, v3}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v8

    if-eqz v8, :cond_c2

    move-object v1, v8

    .restart local v1  # "it":Lkotlin/text/MatchResult;
    const/4 v3, 0x0

    .line 163
    .local v3, "$i$a$-let-XmlProcessor$unlockVehicleSkins$2":I
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {p1, v4, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v8, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v8}, Lcom/twntool/editor/data/SkinData;->getSKINS_BLOCK()Ljava/lang/String;

    move-result-object v8

    .line 164
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v9

    add-int/2addr v9, v5

    invoke-virtual {p1, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 163
    invoke-static {v4, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    return-object v4

    .line 166
    .end local v1  # "it":Lkotlin/text/MatchResult;
    .end local v3  # "$i$a$-let-XmlProcessor$unlockVehicleSkins$2":I
    :cond_c2
    new-instance v5, Lkotlin/text/Regex;

    const-string v8, "</root\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v5, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v5, v8, v4, v1, v3}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 167
    .local v1, "mRoot":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_118

    .line 168
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    invoke-virtual {p1, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v4, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v4}, Lcom/twntool/editor/data/SkinData;->getSKINS_BLOCK()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    .line 169
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 168
    invoke-static {v3, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    goto :goto_139

    .line 170
    :cond_118
    sget-object v3, Lcom/twntool/editor/core/XmlProcessor;->NL:Ljava/lang/String;

    sget-object v4, Lcom/twntool/editor/data/SkinData;->INSTANCE:Lcom/twntool/editor/data/SkinData;

    invoke-virtual {v4}, Lcom/twntool/editor/data/SkinData;->getSKINS_BLOCK()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    .line 167
    :goto_139
    return-object v3
.end method
