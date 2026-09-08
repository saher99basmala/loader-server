# classes4.dex

.class public final Lcom/twntool/editor/core/DesbanEngine;
.super Ljava/lang/Object;
.source "DesbanEngine.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/twntool/editor/core/DesbanEngine$DesbanResult;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000Z\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0003\n\u0002\u0010\u000e\n\u0002\b\u0002\n\u0002\u0010\u0011\n\u0002\b\u0002\n\u0002\u0010 \n\u0002\b\u0002\n\u0002\u0010$\n\u0002\u0018\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\"\n\u0002\b\u0005\n\u0002\u0010\b\n\u0002\b\r\n\u0002\u0018\u0002\n\u0002\b\u0004\n\u0002\u0010\u000b\n\u0002\b\u000f\n\u0002\u0018\u0002\n\u0002\b\n\bÇ\u0002\u0018\u00002\u00020\u0001:\u0001DB\t\b\u0002¢\u0006\u0004\b\u0002\u0010\u0003J)\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00052\u0012\u0010\u0007\u001a\n\u0012\u0006\b\u0001\u0012\u00020\u00010\b\"\u00020\u0001H\u0002¢\u0006\u0002\u0010\tJ\u0010\u0010\u0015\u001a\u00020\u00052\u0006\u0010\u0016\u001a\u00020\u0005H\u0002J\u0010\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\u0018H\u0002J*\u0010\u001a\u001a\u00020\u00052\u0006\u0010\u001b\u001a\u00020\u00052\u0006\u0010\u001c\u001a\u00020\u00052\u0006\u0010\u001d\u001a\u00020\u00052\b\b\u0002\u0010\u001e\u001a\u00020\u0005H\u0002J \u0010\u001f\u001a\u00020\u00052\u0006\u0010 \u001a\u00020\u00052\u0006\u0010!\u001a\u00020\u00052\u0006\u0010\u001c\u001a\u00020\u0005H\u0002J \u0010\"\u001a\u00020\u00052\u0006\u0010 \u001a\u00020\u00052\u0006\u0010!\u001a\u00020\u00052\u0006\u0010\u001c\u001a\u00020\u0005H\u0002J \u0010#\u001a\u00020\u00052\u0006\u0010 \u001a\u00020\u00052\u0006\u0010!\u001a\u00020\u00052\u0006\u0010$\u001a\u00020\u0005H\u0002J>\u0010%\u001a\u0016\u0012\u0006\u0012\u0004\u0018\u00010\u0005\u0012\u0004\u0012\u00020\u0018\u0012\u0004\u0012\u00020\u00180&2\u0006\u0010\u001b\u001a\u00020\u00052\u0006\u0010\'\u001a\u00020\u00052\u0006\u0010(\u001a\u00020\u00052\b\b\u0002\u0010)\u001a\u00020\u0018H\u0002JR\u0010*\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u00052\u0006\u0010.\u001a\u00020\u00052\u0006\u0010/\u001a\u00020\u00052\u0006\u00100\u001a\u00020\u00052\u0006\u00101\u001a\u00020\u00052\u0006\u00102\u001a\u00020\u0005H\u0002JB\u00103\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u00052\u0006\u0010\'\u001a\u00020\u00052\u0006\u0010(\u001a\u00020\u00052\u0006\u00102\u001a\u00020\u0005H\u0002J*\u00104\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J*\u00105\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J\"\u00106\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u0018\u0012\u0004\u0012\u00020\u00180&2\u0006\u0010\u001b\u001a\u00020\u0005H\u0002J*\u00107\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J*\u00108\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J*\u00109\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J\u0016\u0010:\u001a\u00020;2\u0006\u0010<\u001a\u00020\u00052\u0006\u0010=\u001a\u00020\u0005J\u0016\u0010>\u001a\u00020;2\u0006\u0010<\u001a\u00020\u00052\u0006\u0010=\u001a\u00020\u0005J\u0016\u0010?\u001a\u00020;2\u0006\u0010<\u001a\u00020\u00052\u0006\u0010=\u001a\u00020\u0005J*\u0010@\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J*\u0010A\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J*\u0010B\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020+\u0012\u0004\u0012\u00020\u00050&2\u0006\u0010,\u001a\u00020\u00052\u0006\u0010-\u001a\u00020\u0005H\u0002J\u0016\u0010C\u001a\u00020;2\u0006\u0010<\u001a\u00020\u00052\u0006\u0010=\u001a\u00020\u0005R\u0014\u0010\n\u001a\b\u0012\u0004\u0012\u00020\u00050\u000bX\u0082\u0004¢\u0006\u0002\n\u0000R\u0014\u0010\f\u001a\b\u0012\u0004\u0012\u00020\u00050\u000bX\u0082\u0004¢\u0006\u0002\n\u0000R,\u0010\r\u001a \u0012\u0004\u0012\u00020\u0005\u0012\u0016\u0012\u0014\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00100\u000f0\u000b0\u000eX\u0082\u0004¢\u0006\u0002\n\u0000R\u0014\u0010\u0011\u001a\b\u0012\u0004\u0012\u00020\u00050\u0012X\u0082\u0004¢\u0006\u0002\n\u0000R\u0014\u0010\u0013\u001a\b\u0012\u0004\u0012\u00020\u00050\u000bX\u0082\u0004¢\u0006\u0002\n\u0000R\u0014\u0010\u0014\u001a\b\u0012\u0004\u0012\u00020\u00050\u0012X\u0082\u0004¢\u0006\u0002\n\u0000¨\u0006E"
    }
    d2 = {
        "Lcom/twntool/editor/core/DesbanEngine;",
        "",
        "<init>",
        "()V",
        "t",
        "",
        "key",
        "args",
        "",
        "(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;",
        "PROGRESS_VARS",
        "",
        "ACHIEVEMENT_REWARDS",
        "ACHIEVEMENT_COUNTER_MAP",
        "",
        "Lkotlin/Pair;",
        "",
        "NO_COUNTER_IDS",
        "",
        "BARN_ITEMS_LIST",
        "BARN_ITEM_BLOCKLIST",
        "barnVarName",
        "pid",
        "barnCalcWhudup",
        "",
        "upgrades",
        "upsertVar",
        "xml",
        "name",
        "value",
        "tipo",
        "copyVar",
        "my",
        "friend",
        "copyDataElem",
        "replaceBlock",
        "tagName",
        "extractBlock",
        "Lkotlin/Triple;",
        "openPrefix",
        "closeTag",
        "fromPos",
        "cloneXmlBlockPair",
        "",
        "src",
        "tgt",
        "open1",
        "close1",
        "open2",
        "close2",
        "label",
        "cloneBlock",
        "cloneUpgradeBlock",
        "cloneTownAndBuildings",
        "processUnlockAchievements",
        "cloneGlobalVarsECoupons",
        "cloneBarnItems",
        "cloneGlobalBlock",
        "applyEtapa1",
        "Lcom/twntool/editor/core/DesbanEngine$DesbanResult;",
        "myXml",
        "friendXml",
        "applyEtapa2",
        "applyEtapa3",
        "cloneArtInfo",
        "cloneMatch3AdvantagesBoosters",
        "cloneAlterarQuantidadeVars",
        "applyDesban",
        "DesbanResult",
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

.field private static final ACHIEVEMENT_COUNTER_MAP:Ljava/util/Map;
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

.field private static final BARN_ITEMS_LIST:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final BARN_ITEM_BLOCKLIST:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static final INSTANCE:Lcom/twntool/editor/core/DesbanEngine;

.field private static final NO_COUNTER_IDS:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final PROGRESS_VARS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$11S-1D-fFOvwvKd8dxMPagJVCeI(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/DesbanEngine;->processUnlockAchievements$lambda$1(Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$QITcLxbQsEW4nqf2Xt0j9CtBvyk(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/DesbanEngine;->applyEtapa1$lambda$2(Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$mOT-WThnja6-XoS4emekPPTtcTM(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/DesbanEngine;->applyEtapa1$lambda$3(Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .registers 27

    new-instance v0, Lcom/twntool/editor/core/DesbanEngine;

    invoke-direct {v0}, Lcom/twntool/editor/core/DesbanEngine;-><init>()V

    sput-object v0, Lcom/twntool/editor/core/DesbanEngine;->INSTANCE:Lcom/twntool/editor/core/DesbanEngine;

    .line 42
    nop

    .line 43
    const/16 v0, 0x11

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "money"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "moneyCash"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "EarnedCoins"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    .line 44
    const-string v2, "residents"

    const/4 v6, 0x3

    aput-object v2, v1, v6

    .line 43
    nop

    .line 44
    const-string v2, "wheatCounter"

    const/4 v7, 0x4

    aput-object v2, v1, v7

    .line 43
    nop

    .line 44
    const-string v2, "plowFieldsAchiev"

    const/4 v8, 0x5

    aput-object v2, v1, v8

    .line 43
    nop

    .line 45
    const-string v2, "defaultOrdersCount"

    const/4 v9, 0x6

    aput-object v2, v1, v9

    .line 43
    nop

    .line 45
    const-string v2, "match3Life"

    const/4 v10, 0x7

    aput-object v2, v1, v10

    .line 43
    nop

    .line 45
    const-string v2, "Match3Lives_infTime"

    const/16 v11, 0x8

    aput-object v2, v1, v11

    .line 43
    nop

    .line 46
    const/16 v2, 0x9

    const-string v12, "Achievement_IncreasedPopulation"

    aput-object v12, v1, v2

    .line 43
    nop

    .line 46
    const-string v13, "Achievement_PlowedFields"

    const/16 v14, 0xa

    aput-object v13, v1, v14

    .line 43
    nop

    .line 47
    const-string v13, "Achievement_BuiltFactories"

    const/16 v15, 0xb

    aput-object v13, v1, v15

    .line 43
    nop

    .line 47
    const-string v13, "Achievement_SpentCoins"

    const/16 v0, 0xc

    aput-object v13, v1, v0

    .line 43
    nop

    .line 47
    const-string v13, "Achievement_EarneCoins"

    const/16 v17, 0xd

    aput-object v13, v1, v17

    .line 43
    nop

    .line 48
    const-string v13, "spentCash"

    const/16 v18, 0xe

    aput-object v13, v1, v18

    .line 43
    nop

    .line 48
    const-string v13, "earnedCash"

    const/16 v19, 0xf

    aput-object v13, v1, v19

    .line 43
    nop

    .line 48
    const-string v13, "timeInGame"

    const/16 v20, 0x10

    aput-object v13, v1, v20

    .line 43
    nop

    .line 42
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    sput-object v1, Lcom/twntool/editor/core/DesbanEngine;->PROGRESS_VARS:Ljava/util/List;

    .line 52
    nop

    .line 53
    const/16 v1, 0x26

    new-array v13, v1, [Ljava/lang/String;

    const-string v21, "marketBoom"

    aput-object v21, v13, v3

    const-string v21, "miner"

    aput-object v21, v13, v4

    const-string v21, "earthCenter"

    aput-object v21, v13, v5

    const-string v21, "strategyReserv"

    aput-object v21, v13, v6

    const-string v21, "factoryUpgrader"

    aput-object v21, v13, v7

    .line 54
    const-string v21, "collector"

    aput-object v21, v13, v8

    .line 53
    nop

    .line 54
    const-string v21, "teamwork"

    aput-object v21, v13, v9

    .line 53
    nop

    .line 54
    const-string v21, "casinoGame"

    aput-object v21, v13, v10

    .line 53
    nop

    .line 54
    const-string v21, "sendShips"

    aput-object v21, v13, v11

    .line 53
    nop

    .line 54
    const-string v21, "islandGoods"

    aput-object v21, v13, v2

    .line 53
    nop

    .line 55
    const-string v21, "collectBacon"

    aput-object v21, v13, v14

    .line 53
    nop

    .line 55
    const-string v21, "collectHoney"

    aput-object v21, v13, v15

    .line 53
    nop

    .line 55
    const-string v21, "collectorIslands"

    aput-object v21, v13, v0

    .line 53
    nop

    .line 55
    const-string v21, "progressWave"

    aput-object v21, v13, v17

    .line 53
    nop

    .line 56
    const-string v0, "downFeather"

    aput-object v0, v13, v18

    .line 53
    nop

    .line 56
    const-string v22, "metropolis"

    aput-object v22, v13, v19

    .line 53
    nop

    .line 56
    const-string v22, "community_developer"

    aput-object v22, v13, v20

    .line 53
    nop

    .line 56
    const-string v22, "entrepreneur"

    const/16 v16, 0x11

    aput-object v22, v13, v16

    .line 53
    nop

    .line 57
    const-string v22, "lead_Architect"

    const/16 v23, 0x12

    aput-object v22, v13, v23

    .line 53
    nop

    .line 57
    const-string v22, "population_boom"

    const/16 v24, 0x13

    aput-object v22, v13, v24

    .line 53
    nop

    .line 57
    const-string v22, "construction_manager"

    const/16 v24, 0x14

    aput-object v22, v13, v24

    .line 53
    nop

    .line 58
    const-string v22, "endless_fields"

    const/16 v24, 0x15

    aput-object v22, v13, v24

    .line 53
    nop

    .line 58
    const-string v22, "magnate"

    const/16 v24, 0x16

    aput-object v22, v13, v24

    .line 53
    nop

    .line 58
    const-string v22, "wacky_farmer"

    const/16 v24, 0x17

    aput-object v22, v13, v24

    .line 53
    nop

    .line 58
    const-string v22, "urbanist_club"

    const/16 v24, 0x18

    aput-object v22, v13, v24

    .line 53
    nop

    .line 59
    const-string v22, "honorary_freeman"

    const/16 v24, 0x19

    aput-object v22, v13, v24

    .line 53
    nop

    .line 59
    const-string v22, "senior_train_driver"

    const/16 v24, 0x1a

    aput-object v22, v13, v24

    .line 53
    nop

    .line 59
    const-string v22, "road_champ"

    const/16 v24, 0x1b

    aput-object v22, v13, v24

    .line 53
    nop

    .line 60
    const-string v22, "production_genius"

    const/16 v24, 0x1c

    aput-object v22, v13, v24

    .line 53
    nop

    .line 60
    const-string v22, "customer_service_pro"

    const/16 v24, 0x1d

    aput-object v22, v13, v24

    .line 53
    nop

    .line 60
    const-string v22, "model_chicken_coop"

    const/16 v24, 0x1e

    aput-object v22, v13, v24

    .line 53
    nop

    .line 61
    const-string v22, "milky_way"

    const/16 v24, 0x1f

    aput-object v22, v13, v24

    .line 53
    nop

    .line 61
    const-string v22, "mushroom"

    const/16 v24, 0x20

    aput-object v22, v13, v24

    .line 53
    nop

    .line 61
    const-string v22, "wool_art"

    const/16 v24, 0x21

    aput-object v22, v13, v24

    .line 53
    nop

    .line 61
    const-string v22, "seaweed"

    const/16 v24, 0x22

    aput-object v22, v13, v24

    .line 53
    nop

    .line 61
    const-string v22, "donate"

    const/16 v24, 0x23

    aput-object v22, v13, v24

    .line 53
    nop

    .line 62
    const-string v22, "regataChampion"

    const/16 v24, 0x24

    aput-object v22, v13, v24

    .line 53
    nop

    .line 62
    const-string v22, "match3_achievement"

    const/16 v24, 0x25

    aput-object v22, v13, v24

    .line 53
    nop

    .line 52
    invoke-static {v13}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v13

    sput-object v13, Lcom/twntool/editor/core/DesbanEngine;->ACHIEVEMENT_REWARDS:Ljava/util/List;

    .line 66
    nop

    .line 67
    new-array v13, v1, [Lkotlin/Pair;

    const-wide/16 v24, 0x3e80

    invoke-static/range {v24 .. v25}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_MarketBoom"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "marketBoom"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v3

    .line 68
    const-wide/16 v25, 0x36b0

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_Miner"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "miner"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v4

    .line 67
    nop

    .line 69
    const-wide/16 v25, 0x4268

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_EarthCenter"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "earthCenter"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v5

    .line 67
    nop

    .line 70
    const-wide/16 v25, 0xdac

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_StrategyReserv"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "strategyReserv"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v6

    .line 67
    nop

    .line 71
    const-wide/16 v25, 0x2a

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_FactoryUpgrader"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "factoryUpgrader"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v7

    .line 67
    nop

    .line 72
    const-wide/16 v25, 0x19

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_Collector"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "collector"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v8

    .line 67
    nop

    .line 73
    const-wide/16 v25, 0x4e20

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_Teamwork"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "teamwork"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v9

    .line 67
    nop

    .line 74
    const-wide/16 v25, 0xfa0

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_CasinoGame"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "casinoGame"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v10

    .line 67
    nop

    .line 75
    const-wide/16 v25, 0x4650

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_sendShips"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "sendShips"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v11

    .line 67
    nop

    .line 76
    const-wide/32 v25, 0x1adb0

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_islandGoods"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "islandGoods"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v2

    .line 67
    nop

    .line 77
    const-wide/16 v25, 0x3c8c

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_CollectBacon"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "collectBacon"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v14

    .line 67
    nop

    .line 78
    const-wide/16 v25, 0x38a4

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_CollectHoney"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "collectHoney"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0xb

    aput-object v1, v13, v15

    .line 67
    nop

    .line 79
    const-wide/16 v25, 0x1e

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_CollectorIslands"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "collectorIslands"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v15, 0xc

    aput-object v1, v13, v15

    .line 67
    nop

    .line 80
    const-wide/16 v25, 0xa5

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_progressWave"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v15, "progressWave"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v17

    .line 67
    nop

    .line 81
    const-wide/16 v25, 0x36b0

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v15, "Achievement_DownFeather"

    invoke-static {v15, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v18

    .line 67
    nop

    .line 82
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v25, 0x7148

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v15

    invoke-static {v12, v15}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v15

    aput-object v15, v1, v3

    .line 83
    const-wide/16 v25, 0x2ee0

    invoke-static/range {v25 .. v26}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v15

    const-string v14, "Achievement_IncreasedPopulation_Current"

    invoke-static {v14, v15}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v14

    aput-object v14, v1, v4

    .line 82
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v14, "metropolis"

    invoke-static {v14, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v19

    .line 67
    nop

    .line 84
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x46

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v14

    const-string v15, "Achievement_CommunityDeveloper"

    invoke-static {v15, v14}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v14

    aput-object v14, v1, v3

    .line 85
    const-wide/16 v14, 0x46

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v14

    const-string v15, "Achievement_CommunityDeveloper_Current"

    invoke-static {v15, v14}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v14

    aput-object v14, v1, v4

    .line 84
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v14, "community_developer"

    invoke-static {v14, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v20

    .line 67
    nop

    .line 86
    const-wide/16 v14, 0x1bbc

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v14, "Achievement_FillOrders"

    invoke-static {v14, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v14, "entrepreneur"

    invoke-static {v14, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v14, 0x11

    aput-object v1, v13, v14

    .line 67
    nop

    .line 87
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x82

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v14

    const-string v15, "Achievement_BuiltHouses"

    invoke-static {v15, v14}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v14

    aput-object v14, v1, v3

    .line 88
    const-wide/16 v14, 0x1a

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v14

    const-string v15, "Achievement_BuiltHouses_Current"

    invoke-static {v15, v14}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v14

    aput-object v14, v1, v4

    .line 87
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v14, "lead_Architect"

    invoke-static {v14, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    aput-object v1, v13, v23

    .line 67
    nop

    .line 89
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x7148

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v14

    invoke-static {v12, v14}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v3

    .line 90
    const-wide/16 v14, 0x2ee0

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const-string v14, "Achievement_IncreasedPopulation_Current"

    invoke-static {v14, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v4

    .line 89
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "population_boom"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x13

    aput-object v1, v13, v12

    .line 67
    nop

    .line 91
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x2d

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const-string v14, "Achievement_BuiltFactories"

    invoke-static {v14, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v3

    .line 92
    const-wide/16 v14, 0x2d

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const-string v14, "Achievement_BuiltFactories_Current"

    invoke-static {v14, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v4

    .line 91
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "construction_manager"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x14

    aput-object v1, v13, v12

    .line 67
    nop

    .line 93
    const-wide/32 v14, 0xb4aa0

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_PlowedFields"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "endless_fields"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x15

    aput-object v1, v13, v12

    .line 67
    nop

    .line 94
    const-wide/32 v14, 0x29b92700

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_EarneCoins"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "magnate"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x16

    aput-object v1, v13, v12

    .line 67
    nop

    .line 95
    const-wide/16 v14, 0x84

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_GetFields"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "wacky_farmer"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x17

    aput-object v1, v13, v12

    .line 67
    nop

    .line 96
    const-wide/16 v14, 0x186

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_ExpandField"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "urbanist_club"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x18

    aput-object v1, v13, v12

    .line 67
    nop

    .line 97
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0xeb

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const-string v14, "Achievement_EnteredGame"

    invoke-static {v14, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v3

    .line 98
    const-wide/16 v14, 0xf

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const-string v14, "Achievement_EnteredGame_Current"

    invoke-static {v14, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v4

    .line 97
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "honorary_freeman"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x19

    aput-object v1, v13, v12

    .line 67
    nop

    .line 99
    const-wide/16 v14, 0x8fc

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_SentTrain"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "senior_train_driver"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x1a

    aput-object v1, v13, v12

    .line 67
    nop

    .line 100
    new-array v1, v5, [Lkotlin/Pair;

    const-wide/16 v14, 0x1b8

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const-string v14, "Achievement_BuiltRoad"

    invoke-static {v14, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v3

    .line 101
    const-wide/16 v14, 0x1b8

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const-string v14, "Achievement_BuiltRoad_Current"

    invoke-static {v14, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v12

    aput-object v12, v1, v4

    .line 100
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "road_champ"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x1b

    aput-object v1, v13, v12

    .line 67
    nop

    .line 102
    const-wide/32 v14, 0x61a80

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_ProducedProducts"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "production_genius"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x1c

    aput-object v1, v13, v12

    .line 67
    nop

    .line 103
    const-wide/16 v14, 0x1bbc

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_FillOrders"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "customer_service_pro"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x1d

    aput-object v1, v13, v12

    .line 67
    nop

    .line 104
    const-wide/32 v14, 0xea60

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_CollectEggs"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "model_chicken_coop"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x1e

    aput-object v1, v13, v12

    .line 67
    nop

    .line 105
    const-wide/32 v14, 0x1a5e0

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_CollectMilk"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "milky_way"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x1f

    aput-object v1, v13, v12

    .line 67
    nop

    .line 106
    const-wide/16 v14, 0x3908

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_CollectMushroom"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "mushroom"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x20

    aput-object v1, v13, v12

    .line 67
    nop

    .line 107
    const-wide/16 v14, 0x52d0

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_CollectWool"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "wool_art"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x21

    aput-object v1, v13, v12

    .line 67
    nop

    .line 108
    const-wide/16 v14, 0x4e20

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_seaweed"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "seaweed"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x22

    aput-object v1, v13, v12

    .line 67
    nop

    .line 109
    const-wide/16 v14, 0x30d4

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_donate"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "donate"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x23

    aput-object v1, v13, v12

    .line 67
    nop

    .line 110
    const-wide/16 v14, 0x1

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_regataChampion"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "regataChampion"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x24

    aput-object v1, v13, v12

    .line 67
    nop

    .line 111
    const-wide/32 v14, 0xdac0

    invoke-static {v14, v15}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v12, "Achievement_CompleteMatch3Levels"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    const-string v12, "match3_achievement"

    invoke-static {v12, v1}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/16 v12, 0x25

    aput-object v1, v13, v12

    .line 67
    nop

    .line 66
    invoke-static {v13}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v1

    sput-object v1, Lcom/twntool/editor/core/DesbanEngine;->ACHIEVEMENT_COUNTER_MAP:Ljava/util/Map;

    .line 115
    nop

    .line 116
    const/16 v1, 0xc

    new-array v12, v1, [Ljava/lang/String;

    const-string v1, "Brick"

    aput-object v1, v12, v3

    const-string v1, "Glass"

    aput-object v1, v12, v4

    const-string v1, "Plita"

    aput-object v1, v12, v5

    .line 117
    const-string v1, "axe"

    aput-object v1, v12, v6

    .line 116
    nop

    .line 117
    const-string v1, "powersaw"

    aput-object v1, v12, v7

    .line 116
    nop

    .line 118
    const-string v1, "hammerMat"

    aput-object v1, v12, v8

    .line 116
    nop

    .line 118
    const-string v1, "nailMat"

    aput-object v1, v12, v9

    .line 116
    nop

    .line 118
    const-string v1, "paintRedMat"

    aput-object v1, v12, v10

    .line 116
    nop

    .line 119
    const-string v1, "pick"

    aput-object v1, v12, v11

    .line 116
    nop

    .line 119
    const-string v1, "TNT"

    aput-object v1, v12, v2

    .line 116
    nop

    .line 119
    const-string v1, "jackhammer"

    const/16 v13, 0xa

    aput-object v1, v12, v13

    .line 116
    nop

    .line 119
    const-string v1, "drill"

    const/16 v13, 0xb

    aput-object v1, v12, v13

    .line 116
    nop

    .line 115
    invoke-static {v12}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v1

    sput-object v1, Lcom/twntool/editor/core/DesbanEngine;->NO_COUNTER_IDS:Ljava/util/Set;

    .line 123
    nop

    .line 125
    const/16 v1, 0x14a

    new-array v1, v1, [Ljava/lang/String;

    const-string v12, "wheat"

    aput-object v12, v1, v3

    const-string v12, "corn"

    aput-object v12, v1, v4

    const-string v12, "carrot"

    aput-object v12, v1, v5

    const-string v12, "sugarcane"

    aput-object v12, v1, v6

    const-string v12, "cotton"

    aput-object v12, v1, v7

    const-string v12, "strawberry"

    aput-object v12, v1, v8

    const-string v8, "tomat"

    aput-object v8, v1, v9

    const-string v8, "pine"

    aput-object v8, v1, v10

    .line 126
    const-string v8, "potato"

    aput-object v8, v1, v11

    .line 125
    nop

    .line 126
    const-string v8, "cacao"

    aput-object v8, v1, v2

    .line 125
    nop

    .line 126
    const-string v2, "rubberTree"

    const/16 v8, 0xa

    aput-object v2, v1, v8

    .line 125
    nop

    .line 126
    const-string v2, "rubber"

    const/16 v8, 0xb

    aput-object v2, v1, v8

    .line 125
    nop

    .line 126
    const-string v2, "silk"

    const/16 v8, 0xc

    aput-object v2, v1, v8

    .line 125
    nop

    .line 126
    const-string v2, "shelk"

    aput-object v2, v1, v17

    .line 125
    nop

    .line 126
    const-string v2, "pepper"

    aput-object v2, v1, v18

    .line 125
    nop

    .line 126
    const-string v2, "rice"

    aput-object v2, v1, v19

    .line 125
    nop

    .line 127
    const-string v2, "roseSeed"

    aput-object v2, v1, v20

    .line 125
    nop

    .line 127
    const-string v2, "jasmine"

    const/16 v8, 0x11

    aput-object v2, v1, v8

    .line 125
    nop

    .line 127
    const-string v2, "coffee"

    aput-object v2, v1, v23

    .line 125
    nop

    .line 127
    const-string v2, "soybean"

    const/16 v8, 0x13

    aput-object v2, v1, v8

    .line 125
    nop

    .line 127
    const-string v2, "teabush"

    const/16 v8, 0x14

    aput-object v2, v1, v8

    .line 125
    nop

    .line 127
    const-string v2, "mint"

    const/16 v8, 0x15

    aput-object v2, v1, v8

    .line 125
    nop

    .line 127
    const-string v2, "peanut"

    const/16 v8, 0x16

    aput-object v2, v1, v8

    .line 125
    nop

    .line 127
    const-string v2, "lavender"

    const/16 v8, 0x17

    aput-object v2, v1, v8

    .line 125
    nop

    .line 127
    const-string v2, "cork"

    const/16 v8, 0x18

    aput-object v2, v1, v8

    .line 125
    nop

    .line 129
    const-string v2, "milk"

    const/16 v8, 0x19

    aput-object v2, v1, v8

    .line 125
    nop

    .line 129
    const-string v2, "egg"

    const/16 v8, 0x1a

    aput-object v2, v1, v8

    .line 125
    nop

    .line 129
    const-string v2, "wool"

    const/16 v8, 0x1b

    aput-object v2, v1, v8

    .line 125
    nop

    .line 129
    const-string v2, "bacon"

    const/16 v8, 0x1c

    aput-object v2, v1, v8

    .line 125
    nop

    .line 129
    const-string v2, "honeycomb"

    const/16 v8, 0x1d

    aput-object v2, v1, v8

    .line 125
    nop

    .line 129
    const-string v2, "mushroom"

    const/16 v8, 0x1e

    aput-object v2, v1, v8

    .line 125
    nop

    .line 129
    const/16 v2, 0x1f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 129
    const-string v0, "bigFeather"

    const/16 v2, 0x20

    aput-object v0, v1, v2

    .line 125
    nop

    .line 129
    const-string v0, "clay"

    const/16 v2, 0x21

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "apple"

    const/16 v2, 0x22

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "peach"

    const/16 v2, 0x23

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "watermelon"

    const/16 v2, 0x24

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "plum"

    const/16 v2, 0x25

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "grapes"

    const/16 v2, 0x26

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "fish"

    const/16 v2, 0x27

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "shrimp"

    const/16 v2, 0x28

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "lobster"

    const/16 v2, 0x29

    aput-object v0, v1, v2

    .line 125
    nop

    .line 131
    const-string v0, "scallop"

    const/16 v2, 0x2a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "pearl"

    const/16 v2, 0x2b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "seaweed"

    const/16 v2, 0x2c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "banana"

    const/16 v2, 0x2d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "coconut"

    const/16 v2, 0x2e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "pineapple"

    const/16 v2, 0x2f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "olive"

    const/16 v2, 0x30

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "lemon"

    const/16 v2, 0x31

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "aloe"

    const/16 v2, 0x32

    aput-object v0, v1, v2

    .line 125
    nop

    .line 132
    const-string v0, "mango1"

    const/16 v2, 0x33

    aput-object v0, v1, v2

    .line 125
    nop

    .line 134
    const-string v0, "cowfeed"

    const/16 v2, 0x34

    aput-object v0, v1, v2

    .line 125
    nop

    .line 134
    const-string v0, "chickenfeed"

    const/16 v2, 0x35

    aput-object v0, v1, v2

    .line 125
    nop

    .line 134
    const-string v0, "sheepfeed"

    const/16 v2, 0x36

    aput-object v0, v1, v2

    .line 125
    nop

    .line 134
    const-string v0, "pigfeed"

    const/16 v2, 0x37

    aput-object v0, v1, v2

    .line 125
    nop

    .line 134
    const-string v0, "beefeed"

    const/16 v2, 0x38

    aput-object v0, v1, v2

    .line 125
    nop

    .line 134
    const-string v0, "mushroomfeed"

    const/16 v2, 0x39

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "flour"

    const/16 v2, 0x3a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "bread"

    const/16 v2, 0x3b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "cookie"

    const/16 v2, 0x3c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "bagel"

    const/16 v2, 0x3d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "pizza"

    const/16 v2, 0x3e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "potatobread"

    const/16 v2, 0x3f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "bananabread"

    const/16 v2, 0x40

    aput-object v0, v1, v2

    .line 125
    nop

    .line 136
    const-string v0, "mushroomPie"

    const/16 v2, 0x41

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "strudel"

    const/16 v2, 0x42

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "marinepizza"

    const/16 v2, 0x43

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "dough"

    const/16 v2, 0x44

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "cream"

    const/16 v2, 0x45

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "cheese"

    const/16 v2, 0x46

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "butter"

    const/16 v2, 0x47

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "yogurt"

    const/16 v2, 0x48

    aput-object v0, v1, v2

    .line 125
    nop

    .line 137
    const-string v0, "peachyogurt"

    const/16 v2, 0x49

    aput-object v0, v1, v2

    .line 125
    nop

    .line 138
    const-string v0, "sugar"

    const/16 v2, 0x4a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 138
    const-string v0, "syrup"

    const/16 v2, 0x4b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 138
    const-string v0, "caramel"

    const/16 v2, 0x4c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 140
    const-string v0, "candy"

    const/16 v2, 0x4d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 140
    const-string v0, "caramelapple"

    const/16 v2, 0x4e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 140
    const-string v0, "jellybeans"

    const/16 v2, 0x4f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 140
    const-string v0, "toffee"

    const/16 v2, 0x50

    aput-object v0, v1, v2

    .line 125
    nop

    .line 140
    const-string v0, "candystick"

    const/16 v2, 0x51

    aput-object v0, v1, v2

    .line 125
    nop

    .line 140
    const-string v0, "lollipop"

    const/16 v2, 0x52

    aput-object v0, v1, v2

    .line 125
    nop

    .line 140
    const-string v0, "honeycandy"

    const/16 v2, 0x53

    aput-object v0, v1, v2

    .line 125
    nop

    .line 141
    const-string v0, "fruitjelly"

    const/16 v2, 0x54

    aput-object v0, v1, v2

    .line 125
    nop

    .line 141
    const-string v0, "chocobar"

    const/16 v2, 0x55

    aput-object v0, v1, v2

    .line 125
    nop

    .line 141
    const-string v0, "teacandies"

    const/16 v2, 0x56

    aput-object v0, v1, v2

    .line 125
    nop

    .line 141
    const-string v0, "mintlollipops"

    const/16 v2, 0x57

    aput-object v0, v1, v2

    .line 125
    nop

    .line 141
    const-string v0, "cottonCandy"

    const/16 v2, 0x58

    aput-object v0, v1, v2

    .line 125
    nop

    .line 141
    const-string v0, "chocolate"

    const/16 v2, 0x59

    aput-object v0, v1, v2

    .line 125
    nop

    .line 142
    const-string v0, "icecream"

    const/16 v2, 0x5a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 142
    const-string v0, "frozenyogurt"

    const/16 v2, 0x5b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 142
    const-string v0, "fruitice"

    const/16 v2, 0x5c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 142
    const-string v0, "eskimo"

    const/16 v2, 0x5d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 142
    const-string v0, "pineapplesorbet"

    const/16 v2, 0x5e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 142
    const-string v0, "roseSorbet"

    const/16 v2, 0x5f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 143
    const-string v0, "parfait"

    const/16 v2, 0x60

    aput-object v0, v1, v2

    .line 125
    nop

    .line 143
    const-string v0, "mintchocolateicecream"

    const/16 v2, 0x61

    aput-object v0, v1, v2

    .line 125
    nop

    .line 143
    const-string v0, "muffin"

    const/16 v2, 0x62

    aput-object v0, v1, v2

    .line 125
    nop

    .line 143
    const-string v0, "brownie"

    const/16 v2, 0x63

    aput-object v0, v1, v2

    .line 125
    nop

    .line 143
    const-string v0, "cupcake"

    const/16 v2, 0x64

    aput-object v0, v1, v2

    .line 125
    nop

    .line 143
    const-string v0, "doughnut"

    const/16 v2, 0x65

    aput-object v0, v1, v2

    .line 125
    nop

    .line 144
    const-string v0, "cheesecake"

    const/16 v2, 0x66

    aput-object v0, v1, v2

    .line 125
    nop

    .line 144
    const-string v0, "limepie"

    const/16 v2, 0x67

    aput-object v0, v1, v2

    .line 125
    nop

    .line 144
    const-string v0, "coconutmacaroon"

    const/16 v2, 0x68

    aput-object v0, v1, v2

    .line 125
    nop

    .line 144
    const-string v0, "honeycake"

    const/16 v2, 0x69

    aput-object v0, v1, v2

    .line 125
    nop

    .line 144
    const-string v0, "strawberrycake"

    const/16 v2, 0x6a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 144
    const-string v0, "weddingcake"

    const/16 v2, 0x6b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 145
    const-string v0, "coffeecake"

    const/16 v2, 0x6c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 145
    const-string v0, "chocolatecake"

    const/16 v2, 0x6d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 145
    const-string v0, "carrotcake"

    const/16 v2, 0x6e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 145
    const-string v0, "mintcake"

    const/16 v2, 0x6f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 145
    const-string v0, "tiramisu"

    const/16 v2, 0x70

    aput-object v0, v1, v2

    .line 125
    nop

    .line 147
    const-string v0, "chips"

    const/16 v2, 0x71

    aput-object v0, v1, v2

    .line 125
    nop

    .line 147
    const-string v0, "popcorn"

    const/16 v2, 0x72

    aput-object v0, v1, v2

    .line 125
    nop

    .line 147
    const-string v0, "cornchips"

    const/16 v2, 0x73

    aput-object v0, v1, v2

    .line 125
    nop

    .line 147
    const-string v0, "granola"

    const/16 v2, 0x74

    aput-object v0, v1, v2

    .line 125
    nop

    .line 147
    const-string v0, "canape"

    const/16 v2, 0x75

    aput-object v0, v1, v2

    .line 125
    nop

    .line 147
    const-string v0, "glazedbacon"

    const/16 v2, 0x76

    aput-object v0, v1, v2

    .line 125
    nop

    .line 147
    const-string v0, "puffedrice"

    const/16 v2, 0x77

    aput-object v0, v1, v2

    .line 125
    nop

    .line 148
    const-string v0, "saltedpeanut"

    const/16 v2, 0x78

    aput-object v0, v1, v2

    .line 125
    nop

    .line 148
    const-string v0, "frenchfries"

    const/16 v2, 0x79

    aput-object v0, v1, v2

    .line 125
    nop

    .line 148
    const-string v0, "sandwich"

    const/16 v2, 0x7a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 148
    const-string v0, "cheeseburger"

    const/16 v2, 0x7b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 148
    const-string v0, "bakedpotatoes"

    const/16 v2, 0x7c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 148
    const-string v0, "fishburger"

    const/16 v2, 0x7d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 149
    const-string v0, "fish_chips"

    const/16 v2, 0x7e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 149
    const-string v0, "peanot_crepes"

    const/16 v2, 0x7f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 149
    const-string v0, "hot_dog"

    const/16 v2, 0x80

    aput-object v0, v1, v2

    .line 125
    nop

    .line 149
    const-string v0, "corndog"

    const/16 v2, 0x81

    aput-object v0, v1, v2

    .line 125
    nop

    .line 149
    const-string v0, "cheese_coney"

    const/16 v2, 0x82

    aput-object v0, v1, v2

    .line 125
    nop

    .line 149
    const-string v0, "carrot_hotdog"

    const/16 v2, 0x83

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "taco"

    const/16 v2, 0x84

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "nachos"

    const/16 v2, 0x85

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "burrito"

    const/16 v2, 0x86

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "jalapeno"

    const/16 v2, 0x87

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "falafel"

    const/16 v2, 0x88

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "hummus"

    const/16 v2, 0x89

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "guacamole"

    const/16 v2, 0x8a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "bacon_eggs"

    const/16 v2, 0x8b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 150
    const-string v0, "pancake"

    const/16 v2, 0x8c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 152
    const-string v0, "milkshake"

    const/16 v2, 0x8d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 152
    const-string v0, "grap_fizz"

    const/16 v2, 0x8e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 152
    const-string v0, "chocolate_smoothie"

    const/16 v2, 0x8f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 152
    const-string v0, "watermelon_fresh"

    const/16 v2, 0x90

    aput-object v0, v1, v2

    .line 125
    nop

    .line 152
    const-string v0, "tropical_mix"

    const/16 v2, 0x91

    aput-object v0, v1, v2

    .line 125
    nop

    .line 153
    const-string v0, "cold_tea"

    const/16 v2, 0x92

    aput-object v0, v1, v2

    .line 125
    nop

    .line 153
    const-string v0, "minticetea"

    const/16 v2, 0x93

    aput-object v0, v1, v2

    .line 125
    nop

    .line 153
    const-string v0, "applefresh"

    const/16 v2, 0x94

    aput-object v0, v1, v2

    .line 125
    nop

    .line 153
    const-string v0, "espresso"

    const/16 v2, 0x95

    aput-object v0, v1, v2

    .line 125
    nop

    .line 153
    const-string v0, "cappuccino"

    const/16 v2, 0x96

    aput-object v0, v1, v2

    .line 125
    nop

    .line 153
    const-string v0, "mokachino"

    const/16 v2, 0x97

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "hot_chocolate"

    const/16 v2, 0x98

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "blacktea"

    const/16 v2, 0x99

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "whitetea"

    const/16 v2, 0x9a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "rosetea"

    const/16 v2, 0x9b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "tibettea"

    const/16 v2, 0x9c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "oolong"

    const/16 v2, 0x9d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "appletea"

    const/16 v2, 0x9e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 154
    const-string v0, "coconut_raf"

    const/16 v2, 0x9f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "woolfabric"

    const/16 v2, 0xa0

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "cottonfabric"

    const/16 v2, 0xa1

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "silkfabric"

    const/16 v2, 0xa2

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "nylonthread"

    const/16 v2, 0xa3

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "shirt"

    const/16 v2, 0xa4

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "sweater"

    const/16 v2, 0xa5

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "coat"

    const/16 v2, 0xa6

    aput-object v0, v1, v2

    .line 125
    nop

    .line 156
    const-string v0, "hat"

    const/16 v2, 0xa7

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "suit"

    const/16 v2, 0xa8

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "tiroleanHat"

    const/16 v2, 0xa9

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "eveningdress"

    const/16 v2, 0xaa

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "dress"

    const/16 v2, 0xab

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "flipflops"

    const/16 v2, 0xac

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "sandals"

    const/16 v2, 0xad

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "sneakers"

    const/16 v2, 0xae

    aput-object v0, v1, v2

    .line 125
    nop

    .line 157
    const-string v0, "boots"

    const/16 v2, 0xaf

    aput-object v0, v1, v2

    .line 125
    nop

    .line 158
    const-string v0, "heels"

    const/16 v2, 0xb0

    aput-object v0, v1, v2

    .line 125
    nop

    .line 158
    const-string v0, "downBoots"

    const/16 v2, 0xb1

    aput-object v0, v1, v2

    .line 125
    nop

    .line 158
    const-string v0, "downJacket"

    const/16 v2, 0xb2

    aput-object v0, v1, v2

    .line 125
    nop

    .line 158
    const-string v0, "bathrobeslippers"

    const/16 v2, 0xb3

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "paper"

    const/16 v2, 0xb4

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "papertowel"

    const/16 v2, 0xb5

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "wallpapers"

    const/16 v2, 0xb6

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "book"

    const/16 v2, 0xb7

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "stickers"

    const/16 v2, 0xb8

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "marker"

    const/16 v2, 0xb9

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "eraser"

    const/16 v2, 0xba

    aput-object v0, v1, v2

    .line 125
    nop

    .line 160
    const-string v0, "corkboard"

    const/16 v2, 0xbb

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "table"

    const/16 v2, 0xbc

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "chair"

    const/16 v2, 0xbd

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "couch"

    const/16 v2, 0xbe

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "bed"

    const/16 v2, 0xbf

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "floor_lamp"

    const/16 v2, 0xc0

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "pillow"

    const/16 v2, 0xc1

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "duvet"

    const/16 v2, 0xc2

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "tissue"

    const/16 v2, 0xc3

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "dispenser"

    const/16 v2, 0xc4

    aput-object v0, v1, v2

    .line 125
    nop

    .line 161
    const-string v0, "lounge"

    const/16 v2, 0xc5

    aput-object v0, v1, v2

    .line 125
    nop

    .line 163
    const-string v0, "sushi"

    const/16 v2, 0xc6

    aput-object v0, v1, v2

    .line 125
    nop

    .line 163
    const-string v0, "lobster_nigiri"

    const/16 v2, 0xc7

    aput-object v0, v1, v2

    .line 125
    nop

    .line 163
    const-string v0, "scallopsushi"

    const/16 v2, 0xc8

    aput-object v0, v1, v2

    .line 125
    nop

    .line 163
    const-string v0, "soup"

    const/16 v2, 0xc9

    aput-object v0, v1, v2

    .line 125
    nop

    .line 163
    const-string v0, "misosoup"

    const/16 v2, 0xca

    aput-object v0, v1, v2

    .line 125
    nop

    .line 163
    const-string v0, "corn_soup"

    const/16 v2, 0xcb

    aput-object v0, v1, v2

    .line 125
    nop

    .line 163
    const-string v0, "mushroomSoup"

    const/16 v2, 0xcc

    aput-object v0, v1, v2

    .line 125
    nop

    .line 164
    const-string v0, "gazpacho"

    const/16 v2, 0xcd

    aput-object v0, v1, v2

    .line 125
    nop

    .line 164
    const-string v0, "bouillabaisse"

    const/16 v2, 0xce

    aput-object v0, v1, v2

    .line 125
    nop

    .line 164
    const-string v0, "seaweedsalad"

    const/16 v2, 0xcf

    aput-object v0, v1, v2

    .line 125
    nop

    .line 164
    const-string v0, "mushroomSalad"

    const/16 v2, 0xd0

    aput-object v0, v1, v2

    .line 125
    nop

    .line 164
    const-string v0, "seafood_salad"

    const/16 v2, 0xd1

    aput-object v0, v1, v2

    .line 125
    nop

    .line 164
    const-string v0, "nicoise"

    const/16 v2, 0xd2

    aput-object v0, v1, v2

    .line 125
    nop

    .line 165
    const-string v0, "rice_noodle"

    const/16 v2, 0xd3

    aput-object v0, v1, v2

    .line 125
    nop

    .line 165
    const-string v0, "thai_sauce"

    const/16 v2, 0xd4

    aput-object v0, v1, v2

    .line 125
    nop

    .line 165
    const-string v0, "sauce"

    const/16 v2, 0xd5

    aput-object v0, v1, v2

    .line 125
    nop

    .line 165
    const-string v0, "quiche"

    const/16 v2, 0xd6

    aput-object v0, v1, v2

    .line 125
    nop

    .line 165
    const-string v0, "fried_fish"

    const/16 v2, 0xd7

    aput-object v0, v1, v2

    .line 125
    nop

    .line 165
    const-string v0, "rice_casserole"

    const/16 v2, 0xd8

    aput-object v0, v1, v2

    .line 125
    nop

    .line 166
    const-string v0, "baked_lobster"

    const/16 v2, 0xd9

    aput-object v0, v1, v2

    .line 125
    nop

    .line 166
    const-string v0, "lobster_newburg"

    const/16 v2, 0xda

    aput-object v0, v1, v2

    .line 125
    nop

    .line 166
    const-string v0, "scallopskew"

    const/16 v2, 0xdb

    aput-object v0, v1, v2

    .line 125
    nop

    .line 166
    const-string v0, "grilledMeat"

    const/16 v2, 0xdc

    aput-object v0, v1, v2

    .line 125
    nop

    .line 166
    const-string v0, "ratatouille"

    const/16 v2, 0xdd

    aput-object v0, v1, v2

    .line 125
    nop

    .line 167
    const-string v0, "profiteroles"

    const/16 v2, 0xde

    aput-object v0, v1, v2

    .line 125
    nop

    .line 167
    const-string v0, "gyoza"

    const/16 v2, 0xdf

    aput-object v0, v1, v2

    .line 125
    nop

    .line 167
    const-string v0, "readylunch"

    const/16 v2, 0xe0

    aput-object v0, v1, v2

    .line 125
    nop

    .line 167
    const-string v0, "frozenvegetables"

    const/16 v2, 0xe1

    aput-object v0, v1, v2

    .line 125
    nop

    .line 167
    const-string v0, "seafoodcocktail"

    const/16 v2, 0xe2

    aput-object v0, v1, v2

    .line 125
    nop

    .line 167
    const-string v0, "oliveoil"

    const/16 v2, 0xe3

    aput-object v0, v1, v2

    .line 125
    nop

    .line 168
    const-string v0, "bruschetta"

    const/16 v2, 0xe4

    aput-object v0, v1, v2

    .line 125
    nop

    .line 168
    const-string v0, "arrabbiata"

    const/16 v2, 0xe5

    aput-object v0, v1, v2

    .line 125
    nop

    .line 168
    const-string v0, "ravioli"

    const/16 v2, 0xe6

    aput-object v0, v1, v2

    .line 125
    nop

    .line 168
    const-string v0, "lasagna"

    const/16 v2, 0xe7

    aput-object v0, v1, v2

    .line 125
    nop

    .line 168
    const-string v0, "mole"

    const/16 v2, 0xe8

    aput-object v0, v1, v2

    .line 125
    nop

    .line 168
    const-string v0, "vegancheesecake"

    const/16 v2, 0xe9

    aput-object v0, v1, v2

    .line 125
    nop

    .line 170
    const-string v0, "jam"

    const/16 v2, 0xea

    aput-object v0, v1, v2

    .line 125
    nop

    .line 170
    const-string v0, "strawberry_jam"

    const/16 v2, 0xeb

    aput-object v0, v1, v2

    .line 125
    nop

    .line 170
    const-string v0, "peach_jam"

    const/16 v2, 0xec

    aput-object v0, v1, v2

    .line 125
    nop

    .line 170
    const-string v0, "watermelon_jam"

    const/16 v2, 0xed

    aput-object v0, v1, v2

    .line 125
    nop

    .line 170
    const-string v0, "plum_jam"

    const/16 v2, 0xee

    aput-object v0, v1, v2

    .line 125
    nop

    .line 170
    const-string v0, "grapes_jam"

    const/16 v2, 0xef

    aput-object v0, v1, v2

    .line 125
    nop

    .line 170
    const-string v0, "roseJam"

    const/16 v2, 0xf0

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "mushroom_jam"

    const/16 v2, 0xf1

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "applejam"

    const/16 v2, 0xf2

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "peanut_butter"

    const/16 v2, 0xf3

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "ketchup"

    const/16 v2, 0xf4

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "driedMushrooms"

    const/16 v2, 0xf5

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "tofu"

    const/16 v2, 0xf6

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "soymilk"

    const/16 v2, 0xf7

    aput-object v0, v1, v2

    .line 125
    nop

    .line 171
    const-string v0, "custard"

    const/16 v2, 0xf8

    aput-object v0, v1, v2

    .line 125
    nop

    .line 173
    const-string v0, "brownCandle"

    const/16 v2, 0xf9

    aput-object v0, v1, v2

    .line 125
    nop

    .line 173
    const-string v0, "perfumeBottle"

    const/16 v2, 0xfa

    aput-object v0, v1, v2

    .line 125
    nop

    .line 173
    const-string v0, "flowerSoap"

    const/16 v2, 0xfb

    aput-object v0, v1, v2

    .line 125
    nop

    .line 173
    const-string v0, "lotionBottle"

    const/16 v2, 0xfc

    aput-object v0, v1, v2

    .line 125
    nop

    .line 173
    const-string v0, "aromatic_oil"

    const/16 v2, 0xfd

    aput-object v0, v1, v2

    .line 125
    nop

    .line 174
    const-string v0, "air_freshener"

    const/16 v2, 0xfe

    aput-object v0, v1, v2

    .line 125
    nop

    .line 174
    const-string v0, "creammask"

    const/16 v2, 0xff

    aput-object v0, v1, v2

    .line 125
    nop

    .line 174
    const-string v0, "toothpaste"

    const/16 v2, 0x100

    aput-object v0, v1, v2

    .line 125
    nop

    .line 174
    const-string v0, "vitamin_cocktail"

    const/16 v2, 0x101

    aput-object v0, v1, v2

    .line 125
    nop

    .line 174
    const-string v0, "pendant"

    const/16 v2, 0x102

    aput-object v0, v1, v2

    .line 125
    nop

    .line 174
    const-string v0, "ring"

    const/16 v2, 0x103

    aput-object v0, v1, v2

    .line 125
    nop

    .line 175
    const-string v0, "pearlneck"

    const/16 v2, 0x104

    aput-object v0, v1, v2

    .line 125
    nop

    .line 175
    const-string v0, "earrings"

    const/16 v2, 0x105

    aput-object v0, v1, v2

    .line 125
    nop

    .line 175
    const-string v0, "diadem"

    const/16 v2, 0x106

    aput-object v0, v1, v2

    .line 125
    nop

    .line 175
    const-string v0, "featherEarrings"

    const/16 v2, 0x107

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "toys"

    const/16 v2, 0x108

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "ball"

    const/16 v2, 0x109

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "shuttlecock"

    const/16 v2, 0x10a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "Plasticine"

    const/16 v2, 0x10b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "ragdoll"

    const/16 v2, 0x10c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "puppet"

    const/16 v2, 0x10d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "chinadoll"

    const/16 v2, 0x10e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 177
    const-string v0, "barbie"

    const/16 v2, 0x10f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "ukulele"

    const/16 v2, 0x110

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "saxophone"

    const/16 v2, 0x111

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "drum"

    const/16 v2, 0x112

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "accordion"

    const/16 v2, 0x113

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "panpipe"

    const/16 v2, 0x114

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "pettoy"

    const/16 v2, 0x115

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "cattoy"

    const/16 v2, 0x116

    aput-object v0, v1, v2

    .line 125
    nop

    .line 178
    const-string v0, "waterbowl"

    const/16 v2, 0x117

    aput-object v0, v1, v2

    .line 125
    nop

    .line 179
    const-string v0, "catcave"

    const/16 v2, 0x118

    aput-object v0, v1, v2

    .line 125
    nop

    .line 179
    const-string v0, "catlitter"

    const/16 v2, 0x119

    aput-object v0, v1, v2

    .line 125
    nop

    .line 179
    const-string v0, "airballoon"

    const/16 v2, 0x11a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 179
    const-string v0, "soapBubbles"

    const/16 v2, 0x11b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 179
    const-string v0, "lei"

    const/16 v2, 0x11c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 179
    const-string v0, "pinata"

    const/16 v2, 0x11d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 181
    const-string v0, "clover"

    const/16 v2, 0x11e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 181
    const-string v0, "bridebouquet"

    const/16 v2, 0x11f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 181
    const-string v0, "sweetbouquet"

    const/16 v2, 0x120

    aput-object v0, v1, v2

    .line 125
    nop

    .line 181
    const-string v0, "basketbouquet"

    const/16 v2, 0x121

    aput-object v0, v1, v2

    .line 125
    nop

    .line 181
    const-string v0, "teacoffeebouquet"

    const/16 v2, 0x122

    aput-object v0, v1, v2

    .line 125
    nop

    .line 182
    const-string v0, "driedflowers"

    const/16 v2, 0x123

    aput-object v0, v1, v2

    .line 125
    nop

    .line 182
    const-string v0, "summerbouquet"

    const/16 v2, 0x124

    aput-object v0, v1, v2

    .line 125
    nop

    .line 182
    const-string v0, "vegetablebouquet"

    const/16 v2, 0x125

    aput-object v0, v1, v2

    .line 125
    nop

    .line 182
    const-string v0, "toolset"

    const/16 v2, 0x126

    aput-object v0, v1, v2

    .line 125
    nop

    .line 182
    const-string v0, "irrigationhose"

    const/16 v2, 0x127

    aput-object v0, v1, v2

    .line 125
    nop

    .line 183
    const-string v0, "flowertub"

    const/16 v2, 0x128

    aput-object v0, v1, v2

    .line 125
    nop

    .line 183
    const-string v0, "gardengnome"

    const/16 v2, 0x129

    aput-object v0, v1, v2

    .line 125
    nop

    .line 183
    const-string v0, "brush"

    const/16 v2, 0x12a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 183
    const-string v0, "clothesline"

    const/16 v2, 0x12b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 183
    const-string v0, "plunger"

    const/16 v2, 0x12c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 183
    const-string v0, "duster"

    const/16 v2, 0x12d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 183
    const-string v0, "gloves"

    const/16 v2, 0x12e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 184
    const-string v0, "plastic"

    const/16 v2, 0x12f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 184
    const-string v0, "glue"

    const/16 v2, 0x130

    aput-object v0, v1, v2

    .line 125
    nop

    .line 184
    const-string v0, "dumbbell"

    const/16 v2, 0x131

    aput-object v0, v1, v2

    .line 125
    nop

    .line 184
    const-string v0, "plasticbottle"

    const/16 v2, 0x132

    aput-object v0, v1, v2

    .line 125
    nop

    .line 186
    const-string v0, "mug"

    const/16 v2, 0x133

    aput-object v0, v1, v2

    .line 125
    nop

    .line 186
    const-string v0, "frypan"

    const/16 v2, 0x134

    aput-object v0, v1, v2

    .line 125
    nop

    .line 186
    const-string v0, "teapot"

    const/16 v2, 0x135

    aput-object v0, v1, v2

    .line 125
    nop

    .line 186
    const-string v0, "cutlery"

    const/16 v2, 0x136

    aput-object v0, v1, v2

    .line 125
    nop

    .line 186
    const-string v0, "teaceremonykit"

    const/16 v2, 0x137

    aput-object v0, v1, v2

    .line 125
    nop

    .line 186
    const-string v0, "potstand"

    const/16 v2, 0x138

    aput-object v0, v1, v2

    .line 125
    nop

    .line 186
    const-string v0, "newbackpack"

    const/16 v2, 0x139

    aput-object v0, v1, v2

    .line 125
    nop

    .line 187
    const-string v0, "basket"

    const/16 v2, 0x13a

    aput-object v0, v1, v2

    .line 125
    nop

    .line 187
    const-string v0, "handbag"

    const/16 v2, 0x13b

    aput-object v0, v1, v2

    .line 125
    nop

    .line 187
    const-string v0, "suitcase"

    const/16 v2, 0x13c

    aput-object v0, v1, v2

    .line 125
    nop

    .line 187
    const-string v0, "kidsbag"

    const/16 v2, 0x13d

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "Brick"

    const/16 v2, 0x13e

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "Glass"

    const/16 v2, 0x13f

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "Plita"

    const/16 v2, 0x140

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "axe"

    const/16 v2, 0x141

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "powersaw"

    const/16 v2, 0x142

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "hammerMat"

    const/16 v2, 0x143

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "nailMat"

    const/16 v2, 0x144

    aput-object v0, v1, v2

    .line 125
    nop

    .line 189
    const-string v0, "paintRedMat"

    const/16 v2, 0x145

    aput-object v0, v1, v2

    .line 125
    nop

    .line 190
    const-string v0, "pick"

    const/16 v2, 0x146

    aput-object v0, v1, v2

    .line 125
    nop

    .line 190
    const-string v0, "TNT"

    const/16 v2, 0x147

    aput-object v0, v1, v2

    .line 125
    nop

    .line 190
    const-string v0, "jackhammer"

    const/16 v2, 0x148

    aput-object v0, v1, v2

    .line 125
    nop

    .line 190
    const-string v0, "drill"

    const/16 v2, 0x149

    aput-object v0, v1, v2

    .line 125
    nop

    .line 123
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/DesbanEngine;->BARN_ITEMS_LIST:Ljava/util/List;

    .line 194
    new-array v0, v7, [Ljava/lang/String;

    const-string v1, "BronzeBullion"

    aput-object v1, v0, v3

    const-string v1, "SilverBullion"

    aput-object v1, v0, v4

    const-string v1, "GoldBullion"

    aput-object v1, v0, v5

    const-string v1, "PlatinumBullion"

    aput-object v1, v0, v6

    invoke-static {v0}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/twntool/editor/core/DesbanEngine;->BARN_ITEM_BLOCKLIST:Ljava/util/Set;

    sput v11, Lcom/twntool/editor/core/DesbanEngine;->$stable:I

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final applyEtapa1$lambda$2(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 3
    .param p0, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 647
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private static final applyEtapa1$lambda$3(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 3
    .param p0, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 648
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private final barnCalcWhudup(I)I
    .registers 3
    .param p1, "upgrades"  # I

    .line 202
    const v0, 0x1eadabcc

    xor-int/2addr v0, p1

    return v0
.end method

.method private final barnVarName(Ljava/lang/String;)Ljava/lang/String;
    .registers 4
    .param p1, "pid"  # Ljava/lang/String;

    .line 200
    sget-object v0, Lcom/twntool/editor/core/DesbanEngine;->NO_COUNTER_IDS:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    move-object v0, p1

    goto :goto_1d

    :cond_a
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "Counter"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1d
    return-object v0
.end method

.method private final cloneAlterarQuantidadeVars(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 23
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1000
    move-object/from16 v0, p2

    const/16 v1, 0x1e

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "TNT"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "pick"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "axe"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    const/4 v2, 0x3

    const-string v6, "drill"

    aput-object v6, v1, v2

    const/4 v2, 0x4

    const-string v6, "jackhammer"

    aput-object v6, v1, v2

    const/4 v2, 0x5

    const-string v6, "powersaw"

    aput-object v6, v1, v2

    .line 1002
    const-string v2, "gem1"

    const/4 v6, 0x6

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1002
    const-string v2, "gem2"

    const/4 v6, 0x7

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1002
    const-string v2, "gem3"

    const/16 v6, 0x8

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1002
    const-string v2, "sgc1x"

    const/16 v6, 0x9

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1002
    const-string v2, "sgc2x"

    const/16 v6, 0xa

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1002
    const-string v2, "sgc3x"

    const/16 v6, 0xb

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1004
    const-string v2, "o1"

    const/16 v6, 0xc

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1004
    const-string v2, "o2"

    const/16 v6, 0xd

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1004
    const-string v2, "o3"

    const/16 v6, 0xe

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1004
    const-string v2, "o4"

    const/16 v6, 0xf

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1006
    const-string v2, "m1"

    const/16 v6, 0x10

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1006
    const-string v2, "m2"

    const/16 v6, 0x11

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1006
    const-string v2, "m3"

    const/16 v6, 0x12

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1006
    const-string v2, "sm1x"

    const/16 v6, 0x13

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1006
    const-string v2, "sm2x"

    const/16 v6, 0x14

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1006
    const-string v2, "sm3x"

    const/16 v6, 0x15

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1008
    const-string v2, "BronzeBullionCounter"

    const/16 v6, 0x16

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1008
    const-string v2, "SilverBullionCounter"

    const/16 v6, 0x17

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1009
    const-string v2, "GoldBullionCounter"

    const/16 v6, 0x18

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1009
    const-string v2, "PlatinumBullionCounter"

    const/16 v6, 0x19

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1010
    const-string v2, "sbbcx"

    const/16 v6, 0x1a

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1010
    const-string v2, "ssbcx"

    const/16 v6, 0x1b

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1010
    const-string v2, "sgbcx"

    const/16 v6, 0x1c

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 1010
    const-string v2, "spbcx"

    const/16 v6, 0x1d

    aput-object v2, v1, v6

    .line 1000
    nop

    .line 998
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    .line 1021
    .local v1, "ALT_VARS":Ljava/util/List;
    invoke-static/range {p1 .. p1}, Lcom/twntool/editor/core/DesbanEngine;->cloneAlterarQuantidadeVars$globalWindow(Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Number;

    invoke-virtual {v6}, Ljava/lang/Number;->intValue()I

    move-result v6

    .local v6, "srcS":I
    invoke-virtual {v2}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    .line 1022
    .local v2, "srcE":I
    move-object/from16 v7, p1

    invoke-virtual {v7, v6, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    const-string v9, "substring(...)"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1023
    .local v8, "srcWin":Ljava/lang/String;
    invoke-static/range {p2 .. p2}, Lcom/twntool/editor/core/DesbanEngine;->cloneAlterarQuantidadeVars$globalWindow(Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Number;

    invoke-virtual {v11}, Ljava/lang/Number;->intValue()I

    move-result v11

    .local v11, "tgtS":I
    invoke-virtual {v10}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Number;

    invoke-virtual {v10}, Ljava/lang/Number;->intValue()I

    move-result v10

    .line 1024
    .local v10, "tgtE":I
    invoke-virtual {v0, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1026
    .local v12, "tgtWin":Ljava/lang/String;
    const/4 v13, 0x0

    .line 1027
    .local v13, "clonadas":I
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_115
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-eqz v15, :cond_1c9

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 1028
    .local v15, "vname":Ljava/lang/String;
    new-instance v4, Lkotlin/text/Regex;

    sget-object v3, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v3, v15}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v17, v1

    .end local v1  # "ALT_VARS":Ljava/util/List;
    .local v17, "ALT_VARS":Ljava/util/List;
    const-string v1, "<Var\\s+name=\""

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "\"[^>]*\\bv=\"(-?\\d+)\"[^>]*/>"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v4, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 1029
    move-object v3, v8

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    move/from16 v18, v2

    move/from16 v16, v6

    const/4 v2, 0x0

    const/4 v6, 0x2

    .end local v2  # "srcE":I
    .end local v6  # "srcS":I
    .local v16, "srcS":I
    .local v18, "srcE":I
    invoke-static {v4, v3, v2, v6, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 1028
    if-nez v3, :cond_161

    .line 1029
    move v5, v6

    move/from16 v6, v16

    move-object/from16 v1, v17

    move/from16 v2, v18

    const/4 v3, 0x0

    const/4 v4, 0x1

    goto :goto_115

    .line 1028
    :cond_161
    move-object v2, v3

    .line 1030
    .local v2, "mSrc":Lkotlin/text/MatchResult;
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v3

    .line 1031
    .local v3, "fullTag":Ljava/lang/String;
    invoke-static {v3}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 1032
    .local v4, "safe":Ljava/lang/String;
    new-instance v5, Lkotlin/text/Regex;

    sget-object v6, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v6, v15}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v19, v2

    .end local v2  # "mSrc":Lkotlin/text/MatchResult;
    .local v19, "mSrc":Lkotlin/text/MatchResult;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"[^>]*/>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v5, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, v5

    .line 1033
    .local v1, "pat":Lkotlin/text/Regex;
    move-object v2, v12

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1a3

    .line 1034
    move-object v2, v12

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v1, v2, v4}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1ba

    .line 1036
    :cond_1a3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\n    "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1033
    :goto_1ba
    move-object v12, v2

    .line 1038
    nop

    .end local v1  # "pat":Lkotlin/text/Regex;
    .end local v3  # "fullTag":Ljava/lang/String;
    .end local v4  # "safe":Ljava/lang/String;
    .end local v15  # "vname":Ljava/lang/String;
    .end local v19  # "mSrc":Lkotlin/text/MatchResult;
    add-int/lit8 v13, v13, 0x1

    move/from16 v6, v16

    move-object/from16 v1, v17

    move/from16 v2, v18

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x2

    goto/16 :goto_115

    .line 1041
    .end local v16  # "srcS":I
    .end local v17  # "ALT_VARS":Ljava/util/List;
    .end local v18  # "srcE":I
    .local v1, "ALT_VARS":Ljava/util/List;
    .local v2, "srcE":I
    .restart local v6  # "srcS":I
    :cond_1c9
    move-object/from16 v17, v1

    move/from16 v18, v2

    move/from16 v16, v6

    .end local v1  # "ALT_VARS":Ljava/util/List;
    .end local v2  # "srcE":I
    .end local v6  # "srcS":I
    .restart local v16  # "srcS":I
    .restart local v17  # "ALT_VARS":Ljava/util/List;
    .restart local v18  # "srcE":I
    if-nez v13, :cond_1de

    new-instance v1, Lkotlin/Triple;

    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    const-string v3, "AlterarQuantidade: nada copiado"

    invoke-direct {v1, v0, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v1

    .line 1042
    :cond_1de
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1043
    .local v1, "newXml":Ljava/lang/String;
    new-instance v2, Lkotlin/Triple;

    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "AlterarQuantidade: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " vars"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v1, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v2
.end method

.method private static final cloneAlterarQuantidadeVars$globalWindow(Ljava/lang/String;)Lkotlin/Pair;
    .registers 7
    .param p0, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 1014
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "<Global\\b[^>]*>"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, p0

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 1015
    .local v0, "mOpen":Lkotlin/text/MatchResult;
    new-instance v1, Lkotlin/text/Regex;

    const-string v5, "</Global\\s*>"

    invoke-direct {v1, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v5, p0

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v1, v5, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 1016
    .local v1, "mClose":Lkotlin/text/MatchResult;
    if-eqz v0, :cond_55

    if-eqz v1, :cond_55

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v4

    if-le v3, v4, :cond_55

    .line 1017
    new-instance v2, Lkotlin/Pair;

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_67

    .line 1018
    :cond_55
    new-instance v3, Lkotlin/Pair;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    move-object v2, v3

    .line 1016
    :goto_67
    return-object v2
.end method

.method private final cloneArtInfo(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 19
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 817
    move-object/from16 v7, p2

    const/4 v0, 0x0

    .line 818
    .local v0, "bloco":Ljava/lang/String;
    const/16 v13, 0x8

    const/4 v14, 0x0

    const-string v10, "<ArtInfo"

    const-string v11, "</ArtInfo>"

    const/4 v12, 0x0

    move-object/from16 v8, p0

    move-object/from16 v9, p1

    invoke-static/range {v8 .. v14}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    move-object v8, v1

    check-cast v8, Ljava/lang/String;

    .line 819
    .local v8, "b":Ljava/lang/String;
    const-string v9, "<ArtInfo[^>]*?/>"

    const/4 v10, 0x0

    const/4 v11, 0x2

    if-eqz v8, :cond_23

    move-object v0, v8

    move-object v13, v0

    goto :goto_37

    .line 822
    :cond_23
    new-instance v1, Lkotlin/text/Regex;

    invoke-direct {v1, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object/from16 v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v1, v2, v12, v11, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 823
    .local v1, "m":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_36

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v0

    :cond_36
    move-object v13, v0

    .line 825
    .end local v0  # "bloco":Ljava/lang/String;
    .end local v1  # "m":Lkotlin/text/MatchResult;
    .local v13, "bloco":Ljava/lang/String;
    :goto_37
    if-nez v13, :cond_45

    new-instance v0, Lkotlin/Triple;

    invoke-static {v12}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "ArtInfo: não encontrado no doador"

    invoke-direct {v0, v7, v1, v2}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v0

    .line 826
    :cond_45
    invoke-static {v13}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 829
    .local v14, "safe":Ljava/lang/String;
    const/16 v5, 0x8

    const/4 v6, 0x0

    const-string v2, "<ArtInfo"

    const-string v3, "</ArtInfo>"

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-static/range {v0 .. v6}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "btgt":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    .local v2, "ts":I
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    .line 830
    .local v0, "te":I
    const/4 v3, 0x1

    const-string v4, "substring(...)"

    if-eqz v1, :cond_a7

    .line 831
    new-instance v5, Lkotlin/Triple;

    invoke-virtual {v7, v12, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const-string v6, "ArtInfo: substituído"

    invoke-direct {v5, v4, v3, v6}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v5

    .line 834
    :cond_a7
    new-instance v5, Lkotlin/text/Regex;

    invoke-direct {v5, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v6, v7

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v5, v6, v12, v11, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 835
    .local v5, "mSc":Lkotlin/text/MatchResult;
    if-eqz v5, :cond_f5

    .line 836
    new-instance v6, Lkotlin/Triple;

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v9

    invoke-virtual {v7, v12, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v10

    add-int/2addr v10, v3

    invoke-virtual {v7, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 837
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 836
    const-string v9, "ArtInfo: self-closing → bloco completo"

    invoke-direct {v6, v4, v3, v9}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v6

    .line 840
    :cond_f5
    new-instance v6, Lkotlin/text/Regex;

    const-string v9, "</Laboratory\\s*>"

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v6, v9, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v9, v7

    check-cast v9, Ljava/lang/CharSequence;

    invoke-static {v6, v9, v12, v11, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v6

    if-nez v6, :cond_117

    .line 841
    new-instance v6, Lkotlin/text/Regex;

    const-string v9, "<Laboratory\\b[^>]*?/>"

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v6, v9, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v9, v7

    check-cast v9, Ljava/lang/CharSequence;

    invoke-static {v6, v9, v12, v11, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v6

    .line 840
    :cond_117
    nop

    .line 842
    .local v6, "mLab":Lkotlin/text/MatchResult;
    const-string v9, "\n  "

    if-eqz v6, :cond_161

    .line 843
    new-instance v10, Lkotlin/Triple;

    invoke-interface {v6}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v11

    add-int/2addr v11, v3

    invoke-virtual {v7, v12, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v6}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v12

    add-int/2addr v12, v3

    invoke-virtual {v7, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 844
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 843
    const-string v9, "ArtInfo: inserido após Laboratory"

    invoke-direct {v10, v4, v3, v9}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v10

    .line 847
    :cond_161
    new-instance v15, Lkotlin/text/Regex;

    const-string v3, "<BuildingsStash"

    invoke-direct {v15, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v7

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v15, v3, v12, v11, v10}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 848
    .local v3, "mBs":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_1b5

    .line 849
    new-instance v10, Lkotlin/Triple;

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-virtual {v7, v12, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v12

    invoke-virtual {v7, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 850
    const/4 v9, 0x1

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    .line 849
    const-string v11, "ArtInfo: inserido antes BuildingsStash"

    invoke-direct {v10, v4, v9, v11}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v10

    .line 853
    :cond_1b5
    new-instance v9, Lkotlin/text/Regex;

    const-string v15, "</root\\s*>"

    sget-object v10, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v9, v15, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v10, v7

    check-cast v10, Ljava/lang/CharSequence;

    const/4 v15, 0x0

    invoke-static {v9, v10, v12, v11, v15}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    .line 854
    .local v9, "mR":Lkotlin/text/MatchResult;
    const-string v10, "\n"

    if-eqz v9, :cond_20e

    .line 855
    new-instance v11, Lkotlin/Triple;

    invoke-interface {v9}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v15

    invoke-virtual {v7, v12, v15}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v9}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v15

    invoke-virtual {v7, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 856
    const/4 v10, 0x1

    invoke-static {v10}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    .line 855
    const-string v12, "ArtInfo: inserido (fallback root)"

    invoke-direct {v11, v4, v10, v12}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v11

    .line 858
    :cond_20e
    new-instance v4, Lkotlin/Triple;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    const/4 v11, 0x1

    invoke-static {v11}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v11

    const-string v12, "ArtInfo: appended (fallback)"

    invoke-direct {v4, v10, v11, v12}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v4
.end method

.method private final cloneBarnItems(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 24
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 500
    move-object/from16 v0, p2

    const/16 v6, 0x8

    const/4 v7, 0x0

    const-string v3, "<Global"

    const-string v4, "</Global>"

    const/4 v5, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    invoke-static/range {v1 .. v7}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 501
    .local v1, "srcGlobalN":Ljava/lang/String;
    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    if-nez v1, :cond_27

    new-instance v2, Lkotlin/Triple;

    const-string v4, "BarnItems: <Global> não encontrado no doador"

    invoke-direct {v2, v0, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v2

    .line 502
    :cond_27
    move-object v4, v1

    .line 504
    .local v4, "srcGlobal":Ljava/lang/String;
    move-object/from16 v5, p2

    .line 505
    .local v5, "out":Ljava/lang/String;
    const/4 v6, 0x0

    .line 506
    .local v6, "copied":I
    const/4 v7, 0x0

    .line 508
    .local v7, "skipped":I
    sget-object v8, Lcom/twntool/editor/core/DesbanEngine;->BARN_ITEMS_LIST:Ljava/util/List;

    invoke-interface {v8}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_32
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    const/4 v10, 0x1

    if-eqz v9, :cond_164

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 509
    .local v9, "pid":Ljava/lang/String;
    sget-object v11, Lcom/twntool/editor/core/DesbanEngine;->BARN_ITEM_BLOCKLIST:Ljava/util/Set;

    invoke-interface {v11, v9}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_157

    .line 510
    move-object/from16 v11, p0

    invoke-direct {v11, v9}, Lcom/twntool/editor/core/DesbanEngine;->barnVarName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 511
    .local v12, "varName":Ljava/lang/String;
    sget-object v13, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v13, v4, v12}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 512
    .local v13, "rawVal":Ljava/lang/String;
    if-nez v13, :cond_58

    add-int/lit8 v7, v7, 0x1

    goto :goto_32

    .line 513
    :cond_58
    invoke-static {v13}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v14

    .line 514
    .local v14, "qty":Ljava/lang/Integer;
    if-eqz v14, :cond_143

    invoke-virtual {v14}, Ljava/lang/Integer;->intValue()I

    move-result v15

    if-ge v15, v10, :cond_6f

    move-object/from16 v16, v1

    move-object/from16 v17, v4

    move-object/from16 v18, v8

    move-object/from16 v20, v9

    move v9, v2

    goto/16 :goto_14c

    .line 515
    :cond_6f
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "<Var name=\""

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v15, "\" v=\""

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v15, "\" t=\"i\"/>"

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 516
    .local v10, "newTag":Ljava/lang/String;
    invoke-static {v10}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 517
    .local v15, "safe":Ljava/lang/String;
    new-instance v2, Lkotlin/text/Regex;

    move-object/from16 v16, v1

    .end local v1  # "srcGlobalN":Ljava/lang/String;
    .local v16, "srcGlobalN":Ljava/lang/String;
    sget-object v1, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v1, v12}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v17, v4

    .end local v4  # "srcGlobal":Ljava/lang/String;
    .local v17, "srcGlobal":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v8

    const-string v8, "<Var\\b[^>]*?name=\""

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "\"[^>]*/>"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, v2

    .line 518
    .local v1, "pattern":Lkotlin/text/Regex;
    move-object v2, v5

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_da

    .line 519
    move-object v2, v5

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v15}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v1, v2, v15}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v19, v1

    move-object/from16 v20, v9

    const/4 v9, 0x0

    goto :goto_136

    .line 521
    :cond_da
    new-instance v2, Lkotlin/text/Regex;

    const-string v4, "</Global\\s*>"

    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v2, v4, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v4, v5

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v8, 0x2

    move-object/from16 v19, v1

    .end local v1  # "pattern":Lkotlin/text/Regex;
    .local v19, "pattern":Lkotlin/text/Regex;
    const/4 v1, 0x0

    move-object/from16 v20, v9

    const/4 v9, 0x0

    .end local v9  # "pid":Ljava/lang/String;
    .local v20, "pid":Ljava/lang/String;
    invoke-static {v2, v4, v9, v8, v1}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 522
    .local v1, "mClose":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_135

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v2

    invoke-virtual {v5, v9, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    const-string v4, "substring(...)"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {v5, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\t\t"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\n"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_136

    .line 523
    :cond_135
    move-object v2, v5

    .line 518
    .end local v1  # "mClose":Lkotlin/text/MatchResult;
    :goto_136
    move-object v5, v2

    .line 525
    nop

    .end local v10  # "newTag":Ljava/lang/String;
    .end local v12  # "varName":Ljava/lang/String;
    .end local v13  # "rawVal":Ljava/lang/String;
    .end local v14  # "qty":Ljava/lang/Integer;
    .end local v15  # "safe":Ljava/lang/String;
    .end local v19  # "pattern":Lkotlin/text/Regex;
    .end local v20  # "pid":Ljava/lang/String;
    add-int/lit8 v6, v6, 0x1

    move v2, v9

    move-object/from16 v1, v16

    move-object/from16 v4, v17

    move-object/from16 v8, v18

    goto/16 :goto_32

    .line 514
    .end local v16  # "srcGlobalN":Ljava/lang/String;
    .end local v17  # "srcGlobal":Ljava/lang/String;
    .local v1, "srcGlobalN":Ljava/lang/String;
    .restart local v4  # "srcGlobal":Ljava/lang/String;
    .restart local v9  # "pid":Ljava/lang/String;
    .restart local v12  # "varName":Ljava/lang/String;
    .restart local v13  # "rawVal":Ljava/lang/String;
    .restart local v14  # "qty":Ljava/lang/Integer;
    :cond_143
    move-object/from16 v16, v1

    move-object/from16 v17, v4

    move-object/from16 v18, v8

    move-object/from16 v20, v9

    move v9, v2

    .end local v1  # "srcGlobalN":Ljava/lang/String;
    .end local v4  # "srcGlobal":Ljava/lang/String;
    .end local v9  # "pid":Ljava/lang/String;
    .restart local v16  # "srcGlobalN":Ljava/lang/String;
    .restart local v17  # "srcGlobal":Ljava/lang/String;
    .restart local v20  # "pid":Ljava/lang/String;
    :goto_14c
    add-int/lit8 v7, v7, 0x1

    move v2, v9

    move-object/from16 v1, v16

    move-object/from16 v4, v17

    move-object/from16 v8, v18

    goto/16 :goto_32

    .line 509
    .end local v12  # "varName":Ljava/lang/String;
    .end local v13  # "rawVal":Ljava/lang/String;
    .end local v14  # "qty":Ljava/lang/Integer;
    .end local v16  # "srcGlobalN":Ljava/lang/String;
    .end local v17  # "srcGlobal":Ljava/lang/String;
    .end local v20  # "pid":Ljava/lang/String;
    .restart local v1  # "srcGlobalN":Ljava/lang/String;
    .restart local v4  # "srcGlobal":Ljava/lang/String;
    .restart local v9  # "pid":Ljava/lang/String;
    :cond_157
    move-object/from16 v11, p0

    move-object/from16 v16, v1

    move-object/from16 v17, v4

    move-object/from16 v18, v8

    move-object/from16 v20, v9

    move v9, v2

    .end local v1  # "srcGlobalN":Ljava/lang/String;
    .end local v4  # "srcGlobal":Ljava/lang/String;
    .end local v9  # "pid":Ljava/lang/String;
    .restart local v16  # "srcGlobalN":Ljava/lang/String;
    .restart local v17  # "srcGlobal":Ljava/lang/String;
    .restart local v20  # "pid":Ljava/lang/String;
    goto/16 :goto_32

    .line 527
    .end local v16  # "srcGlobalN":Ljava/lang/String;
    .end local v17  # "srcGlobal":Ljava/lang/String;
    .end local v20  # "pid":Ljava/lang/String;
    .restart local v1  # "srcGlobalN":Ljava/lang/String;
    .restart local v4  # "srcGlobal":Ljava/lang/String;
    :cond_164
    move-object/from16 v11, p0

    move-object/from16 v16, v1

    move-object/from16 v17, v4

    .end local v1  # "srcGlobalN":Ljava/lang/String;
    .end local v4  # "srcGlobal":Ljava/lang/String;
    .restart local v16  # "srcGlobalN":Ljava/lang/String;
    .restart local v17  # "srcGlobal":Ljava/lang/String;
    if-lez v6, :cond_18f

    new-instance v1, Lkotlin/Triple;

    invoke-static {v10}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "BarnItems: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " itens copiados"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v5, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_196

    .line 528
    :cond_18f
    new-instance v1, Lkotlin/Triple;

    const-string v2, "BarnItems: nenhum item válido no doador"

    invoke-direct {v1, v0, v3, v2}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 527
    :goto_196
    return-object v1
.end method

.method private final cloneBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 22
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .param p3, "openPrefix"  # Ljava/lang/String;
    .param p4, "closeTag"  # Ljava/lang/String;
    .param p5, "label"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 300
    move-object/from16 v0, p2

    move-object/from16 v1, p5

    const/16 v7, 0x8

    const/4 v8, 0x0

    const/4 v6, 0x0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    invoke-static/range {v2 .. v8}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 301
    .local v2, "bloco":Ljava/lang/String;
    const/4 v3, 0x0

    if-nez v2, :cond_3a

    new-instance v4, Lkotlin/Triple;

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ": não encontrado no doador"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v0, v3, v5}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v4

    .line 302
    :cond_3a
    new-instance v4, Lkotlin/text/Regex;

    sget-object v5, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v6, p3

    invoke-virtual {v5, v6}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    sget-object v7, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v8, p4

    invoke-virtual {v7, v8}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v9, ".*?"

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sget-object v7, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v4, v5, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 303
    .local v4, "tgtRe":Lkotlin/text/Regex;
    invoke-static {v2}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 304
    .local v5, "safe":Ljava/lang/String;
    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    invoke-virtual {v4, v7}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v7

    const/4 v9, 0x1

    if-eqz v7, :cond_9e

    .line 305
    new-instance v3, Lkotlin/Triple;

    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v4, v7, v5}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ": substituído"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v3, v7, v9, v10}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto/16 :goto_15f

    .line 307
    :cond_9e
    new-instance v7, Lkotlin/text/Regex;

    const-string v10, "</Global\\s*>"

    sget-object v11, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v7, v10, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    const/4 v11, 0x2

    const/4 v12, 0x0

    invoke-static {v7, v10, v3, v11, v12}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 308
    .local v7, "mG":Lkotlin/text/MatchResult;
    new-instance v10, Lkotlin/text/Regex;

    const-string v13, "</root\\s*>"

    sget-object v14, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v10, v13, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v13, v0

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v10, v13, v3, v11, v12}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    .line 309
    .local v10, "mR":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_d1

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    if-eqz v11, :cond_d1

    :goto_c8
    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    goto :goto_da

    :cond_d1
    if-eqz v10, :cond_da

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    if-eqz v11, :cond_da

    goto :goto_c8

    :cond_da
    :goto_da
    move-object v11, v12

    .line 310
    .local v11, "insertAt":Ljava/lang/Integer;
    const-string v12, "\n"

    if-eqz v11, :cond_12e

    new-instance v13, Lkotlin/Triple;

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v14

    invoke-virtual {v0, v3, v14}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v14, "substring(...)"

    invoke-static {v3, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v15

    invoke-virtual {v0, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v14, ": inserido"

    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-direct {v13, v3, v9, v12}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    move-object v3, v13

    goto :goto_15f

    .line 311
    :cond_12e
    new-instance v3, Lkotlin/Triple;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ": appended"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v3, v12, v9, v13}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 304
    .end local v7  # "mG":Lkotlin/text/MatchResult;
    .end local v10  # "mR":Lkotlin/text/MatchResult;
    .end local v11  # "insertAt":Ljava/lang/Integer;
    :goto_15f
    return-object v3
.end method

.method private final cloneGlobalBlock(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 27
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 533
    move-object/from16 v7, p2

    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "MyBadge"

    const/4 v8, 0x0

    .line 536
    invoke-static {v8}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    .line 533
    aput-object v1, v0, v8

    const-string v1, "MyPicture"

    const/4 v10, 0x1

    aput-object v1, v0, v10

    const-string v1, "MyTheme"

    const/4 v11, 0x2

    aput-object v1, v0, v11

    const/4 v1, 0x3

    const-string v2, "MyFrame"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "MyStyle"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "townName"

    aput-object v2, v0, v1

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v12

    .line 534
    .local v12, "MY_VARS":Ljava/util/List;
    const/16 v5, 0x8

    const/4 v6, 0x0

    const-string v2, "<Global"

    const-string v3, "</Global>"

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static/range {v0 .. v6}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v0

    move-object v13, v0

    check-cast v13, Ljava/lang/String;

    .line 535
    .local v13, "srcGlobalN":Ljava/lang/String;
    const-string v2, "<Global"

    const-string v3, "</Global>"

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-static/range {v0 .. v6}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "tgtGlobalN":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    .local v2, "tgS":I
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    .line 536
    .local v0, "tgE":I
    if-eqz v13, :cond_25b

    if-nez v1, :cond_70

    move-object/from16 v19, v1

    goto/16 :goto_25d

    .line 537
    :cond_70
    move-object v3, v13

    .line 538
    .local v3, "srcGlobal":Ljava/lang/String;
    move-object v4, v1

    .line 540
    .local v4, "newGlobal":Ljava/lang/String;
    new-instance v5, Ljava/util/LinkedHashMap;

    invoke-direct {v5}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v5, Ljava/util/Map;

    .line 541
    .local v5, "donorVars":Ljava/util/Map;
    new-instance v6, Lkotlin/text/Regex;

    const-string v14, "<Var\\b[^>]*?name=\"([^\"]*)\"[^>]*/>"

    invoke-direct {v6, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 542
    .local v6, "varRe":Lkotlin/text/Regex;
    move-object v14, v3

    check-cast v14, Ljava/lang/CharSequence;

    const/4 v15, 0x0

    invoke-static {v6, v14, v8, v11, v15}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v14

    invoke-interface {v14}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_8c
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_dd

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lkotlin/text/MatchResult;

    .line 543
    .local v16, "m":Lkotlin/text/MatchResult;
    invoke-interface/range {v16 .. v16}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 544
    .local v8, "name":Ljava/lang/String;
    invoke-interface {v12, v8}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v17

    if-eqz v17, :cond_d5

    .line 545
    new-instance v10, Lkotlin/text/Regex;

    const-string v11, "\\bv=\"([^\"]*)\""

    invoke-direct {v10, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface/range {v16 .. v16}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v11

    check-cast v11, Ljava/lang/CharSequence;

    move-object/from16 v19, v1

    move-object/from16 v20, v3

    const/4 v1, 0x0

    const/4 v3, 0x2

    .end local v1  # "tgtGlobalN":Ljava/lang/String;
    .end local v3  # "srcGlobal":Ljava/lang/String;
    .local v19, "tgtGlobalN":Ljava/lang/String;
    .local v20, "srcGlobal":Ljava/lang/String;
    invoke-static {v10, v11, v1, v3, v15}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    .line 546
    .local v10, "mv":Lkotlin/text/MatchResult;
    if-eqz v10, :cond_cd

    invoke-interface {v10}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    const/4 v3, 0x1

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v5, v8, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_cd
    move-object/from16 v1, v19

    move-object/from16 v3, v20

    const/4 v8, 0x0

    const/4 v10, 0x1

    const/4 v11, 0x2

    goto :goto_8c

    .line 544
    .end local v10  # "mv":Lkotlin/text/MatchResult;
    .end local v19  # "tgtGlobalN":Ljava/lang/String;
    .end local v20  # "srcGlobal":Ljava/lang/String;
    .restart local v1  # "tgtGlobalN":Ljava/lang/String;
    .restart local v3  # "srcGlobal":Ljava/lang/String;
    :cond_d5
    move-object/from16 v19, v1

    move-object/from16 v20, v3

    .end local v1  # "tgtGlobalN":Ljava/lang/String;
    .end local v3  # "srcGlobal":Ljava/lang/String;
    .restart local v19  # "tgtGlobalN":Ljava/lang/String;
    .restart local v20  # "srcGlobal":Ljava/lang/String;
    const/4 v8, 0x0

    const/4 v10, 0x1

    const/4 v11, 0x2

    goto :goto_8c

    .line 549
    .end local v8  # "name":Ljava/lang/String;
    .end local v16  # "m":Lkotlin/text/MatchResult;
    .end local v19  # "tgtGlobalN":Ljava/lang/String;
    .end local v20  # "srcGlobal":Ljava/lang/String;
    .restart local v1  # "tgtGlobalN":Ljava/lang/String;
    .restart local v3  # "srcGlobal":Ljava/lang/String;
    :cond_dd
    move-object/from16 v19, v1

    move-object/from16 v20, v3

    .end local v1  # "tgtGlobalN":Ljava/lang/String;
    .end local v3  # "srcGlobal":Ljava/lang/String;
    .restart local v19  # "tgtGlobalN":Ljava/lang/String;
    .restart local v20  # "srcGlobal":Ljava/lang/String;
    invoke-interface {v5}, Ljava/util/Map;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_ef

    new-instance v1, Lkotlin/Triple;

    const-string v3, "Aparência: nenhum var encontrado no doador"

    invoke-direct {v1, v7, v9, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v1

    .line 551
    :cond_ef
    const/4 v1, 0x0

    .line 552
    .local v1, "copied":I
    invoke-interface {v5}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_f8
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    const-string v9, "substring(...)"

    if-eqz v8, :cond_20f

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .local v10, "name":Ljava/lang/String;
    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 553
    .local v8, "value":Ljava/lang/String;
    new-instance v11, Lkotlin/text/Regex;

    sget-object v14, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v14, v10}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v21, v3

    const-string v3, "<Var\\b[^>]*?name=\""

    invoke-virtual {v15, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v14, "\"[^>]*/>"

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v11, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v11

    .line 554
    .local v3, "pattern":Lkotlin/text/Regex;
    move-object v11, v4

    check-cast v11, Ljava/lang/CharSequence;

    move-object/from16 v22, v5

    const/4 v5, 0x2

    const/4 v14, 0x0

    const/4 v15, 0x0

    .end local v5  # "donorVars":Ljava/util/Map;
    .local v22, "donorVars":Ljava/util/Map;
    invoke-static {v3, v11, v15, v5, v14}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v11

    .line 555
    .local v11, "m":Lkotlin/text/MatchResult;
    if-eqz v11, :cond_189

    .line 556
    new-instance v5, Lkotlin/text/Regex;

    const-string v9, "\\bv=\"[^\"]*\""

    invoke-direct {v5, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v11}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v9

    check-cast v9, Ljava/lang/CharSequence;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "v=\""

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "\""

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v5, v9, v14}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 557
    .local v5, "updated":Ljava/lang/String;
    invoke-static {v5}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 558
    .local v9, "safe":Ljava/lang/String;
    move-object v14, v4

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3, v14, v9}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v23, v3

    move-object/from16 v16, v6

    move-object/from16 v18, v8

    const/4 v8, 0x2

    const/4 v15, 0x0

    .end local v5  # "updated":Ljava/lang/String;
    .end local v9  # "safe":Ljava/lang/String;
    goto/16 :goto_203

    .line 560
    :cond_189
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "<Var name=\""

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v14, "\" v=\""

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v14, "\"/>"

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 561
    .local v5, "newVar":Ljava/lang/String;
    new-instance v14, Lkotlin/text/Regex;

    const-string v15, "</Global\\s*>"

    move-object/from16 v23, v3

    .end local v3  # "pattern":Lkotlin/text/Regex;
    .local v23, "pattern":Lkotlin/text/Regex;
    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v14, v15, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, v4

    check-cast v3, Ljava/lang/CharSequence;

    move-object/from16 v16, v6

    move-object/from16 v18, v8

    const/4 v6, 0x0

    const/4 v8, 0x2

    const/4 v15, 0x0

    .end local v6  # "varRe":Lkotlin/text/Regex;
    .end local v8  # "value":Ljava/lang/String;
    .local v16, "varRe":Lkotlin/text/Regex;
    .local v18, "value":Ljava/lang/String;
    invoke-static {v14, v3, v6, v8, v15}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 562
    .local v3, "mClose":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_202

    .line 563
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v14

    invoke-virtual {v14}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v14

    invoke-virtual {v4, v6, v14}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v14, "\n"

    invoke-virtual {v9, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v5, v6

    goto :goto_203

    .line 564
    :cond_202
    move-object v5, v4

    .line 555
    .end local v3  # "mClose":Lkotlin/text/MatchResult;
    .end local v5  # "newVar":Ljava/lang/String;
    :goto_203
    move-object v4, v5

    .line 566
    nop

    .end local v10  # "name":Ljava/lang/String;
    .end local v11  # "m":Lkotlin/text/MatchResult;
    .end local v18  # "value":Ljava/lang/String;
    .end local v23  # "pattern":Lkotlin/text/Regex;
    add-int/lit8 v1, v1, 0x1

    move-object/from16 v6, v16

    move-object/from16 v3, v21

    move-object/from16 v5, v22

    goto/16 :goto_f8

    .line 568
    .end local v16  # "varRe":Lkotlin/text/Regex;
    .end local v22  # "donorVars":Ljava/util/Map;
    .local v5, "donorVars":Ljava/util/Map;
    .restart local v6  # "varRe":Lkotlin/text/Regex;
    :cond_20f
    move-object/from16 v22, v5

    move-object/from16 v16, v6

    .end local v5  # "donorVars":Ljava/util/Map;
    .end local v6  # "varRe":Lkotlin/text/Regex;
    .restart local v16  # "varRe":Lkotlin/text/Regex;
    .restart local v22  # "donorVars":Ljava/util/Map;
    new-instance v3, Lkotlin/Triple;

    const/4 v5, 0x0

    invoke-virtual {v7, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

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

    const/4 v6, 0x1

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Aparência: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " vars copiadas"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v3, v5, v6, v8}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .line 536
    .end local v4  # "newGlobal":Ljava/lang/String;
    .end local v16  # "varRe":Lkotlin/text/Regex;
    .end local v19  # "tgtGlobalN":Ljava/lang/String;
    .end local v20  # "srcGlobal":Ljava/lang/String;
    .end local v22  # "donorVars":Ljava/util/Map;
    .local v1, "tgtGlobalN":Ljava/lang/String;
    :cond_25b
    move-object/from16 v19, v1

    .end local v1  # "tgtGlobalN":Ljava/lang/String;
    .restart local v19  # "tgtGlobalN":Ljava/lang/String;
    :goto_25d
    new-instance v1, Lkotlin/Triple;

    const-string v3, "Aparência: Global não encontrado"

    invoke-direct {v1, v7, v9, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v1
.end method

.method private final cloneGlobalVarsECoupons(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 41
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 423
    move-object/from16 v8, p2

    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "m3Line"

    const/4 v9, 0x0

    .line 429
    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    .line 423
    aput-object v1, v0, v9

    const-string v1, "m3Bomb"

    const/4 v11, 0x1

    aput-object v1, v0, v11

    const-string v1, "m3RainbowBall"

    const/4 v12, 0x2

    aput-object v1, v0, v12

    const-string v1, "m3Mallet"

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 424
    const-string v1, "m3HorizontalLine"

    const/4 v3, 0x4

    aput-object v1, v0, v3

    .line 423
    nop

    .line 424
    const-string v1, "m3VerticalLine"

    const/4 v4, 0x5

    aput-object v1, v0, v4

    .line 423
    nop

    .line 424
    const-string v1, "m3Reshuffle"

    const/4 v5, 0x6

    aput-object v1, v0, v5

    .line 423
    invoke-static {v0}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v13

    .line 425
    .local v13, "EXACT_VARS":Ljava/util/Set;
    new-array v0, v4, [Ljava/lang/String;

    const-string v1, "HireDealer"

    aput-object v1, v0, v9

    const-string v1, "LoadTrainAirport"

    aput-object v1, v0, v11

    const-string v1, "UpgradeFactory"

    aput-object v1, v0, v12

    const-string v1, "UpgradeTrain"

    aput-object v1, v0, v2

    const-string v1, "UpgradeIsland"

    aput-object v1, v0, v3

    invoke-static {v0}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v14

    .line 427
    .local v14, "COUPON_IDS":Ljava/util/Set;
    const/16 v5, 0x8

    const/4 v6, 0x0

    const-string v2, "<Global"

    const-string v3, "</Global>"

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static/range {v0 .. v6}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v0

    move-object v15, v0

    check-cast v15, Ljava/lang/String;

    .line 428
    .local v15, "srcGlobalN":Ljava/lang/String;
    const/16 v6, 0x8

    const/4 v7, 0x0

    const-string v3, "<Global"

    const-string v4, "</Global>"

    const/4 v5, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, p2

    invoke-static/range {v1 .. v7}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "tgtGlobalN":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    .local v2, "tgS":I
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v3

    .line 429
    .local v3, "tgE":I
    if-nez v15, :cond_97

    new-instance v0, Lkotlin/Triple;

    const-string v4, "GlobalVars: <Global> não encontrado no doador"

    invoke-direct {v0, v8, v10, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v0

    .line 430
    :cond_97
    if-nez v1, :cond_a1

    new-instance v0, Lkotlin/Triple;

    const-string v4, "GlobalVars: <Global> não encontrado no alvo"

    invoke-direct {v0, v8, v10, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v0

    .line 431
    :cond_a1
    move-object v4, v15

    .line 432
    .local v4, "srcGlobal":Ljava/lang/String;
    move-object v0, v1

    .line 433
    .local v0, "newGlobal":Ljava/lang/String;
    const/4 v5, 0x0

    .line 436
    .local v5, "copyCount":I
    new-instance v6, Lkotlin/text/Regex;

    const-string v7, "<Var\\b[^>]*?name=\"([^\"]*)\"[^>]*/>"

    invoke-direct {v6, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 437
    .local v6, "varRe":Lkotlin/text/Regex;
    move-object v7, v4

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v10, 0x0

    invoke-static {v6, v7, v9, v12, v10}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v7

    invoke-interface {v7}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_b7
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    const-string v9, "\n"

    const-string v10, "</Global\\s*>"

    const-string v12, "\"[^>]*/>"

    const-string v11, "substring(...)"

    if-eqz v16, :cond_1bd

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lkotlin/text/MatchResult;

    .line 438
    .local v16, "m":Lkotlin/text/MatchResult;
    move-object/from16 v25, v1

    .end local v1  # "tgtGlobalN":Ljava/lang/String;
    .local v25, "tgtGlobalN":Ljava/lang/String;
    invoke-interface/range {v16 .. v16}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    move-object/from16 v26, v6

    const/4 v6, 0x1

    .end local v6  # "varRe":Lkotlin/text/Regex;
    .local v26, "varRe":Lkotlin/text/Regex;
    invoke-interface {v1, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 439
    .local v1, "name":Ljava/lang/String;
    invoke-interface {v13, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_111

    const-string v6, "Boost"

    move-object/from16 v17, v7

    move-object/from16 v27, v13

    move-object/from16 v28, v15

    const/4 v7, 0x0

    const/4 v13, 0x0

    const/4 v15, 0x2

    .end local v13  # "EXACT_VARS":Ljava/util/Set;
    .end local v15  # "srcGlobalN":Ljava/lang/String;
    .local v27, "EXACT_VARS":Ljava/util/Set;
    .local v28, "srcGlobalN":Ljava/lang/String;
    invoke-static {v1, v6, v13, v15, v7}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_117

    const-string v6, "Achievement_"

    invoke-static {v1, v6, v13, v15, v7}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_117

    const-string v6, "AchReward_"

    invoke-static {v1, v6, v13, v15, v7}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_102

    goto :goto_117

    :cond_102
    move-object/from16 v7, v17

    move-object/from16 v1, v25

    move-object/from16 v6, v26

    move-object/from16 v13, v27

    move-object/from16 v15, v28

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x1

    const/4 v12, 0x2

    goto :goto_b7

    .end local v27  # "EXACT_VARS":Ljava/util/Set;
    .end local v28  # "srcGlobalN":Ljava/lang/String;
    .restart local v13  # "EXACT_VARS":Ljava/util/Set;
    .restart local v15  # "srcGlobalN":Ljava/lang/String;
    :cond_111
    move-object/from16 v17, v7

    move-object/from16 v27, v13

    move-object/from16 v28, v15

    .line 440
    .end local v13  # "EXACT_VARS":Ljava/util/Set;
    .end local v15  # "srcGlobalN":Ljava/lang/String;
    .restart local v27  # "EXACT_VARS":Ljava/util/Set;
    .restart local v28  # "srcGlobalN":Ljava/lang/String;
    :cond_117
    :goto_117
    invoke-interface/range {v16 .. v16}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v6

    .line 441
    .local v6, "fullTag":Ljava/lang/String;
    invoke-static {v6}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 442
    .local v7, "safe":Ljava/lang/String;
    new-instance v13, Lkotlin/text/Regex;

    sget-object v15, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v15, v1}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    move-object/from16 v18, v1

    .end local v1  # "name":Ljava/lang/String;
    .local v18, "name":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v29, v3

    .end local v3  # "tgE":I
    .local v29, "tgE":I
    const-string v3, "<Var\\b[^>]*?name=\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v13, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, v13

    .line 443
    .local v1, "tgtVarRe":Lkotlin/text/Regex;
    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    invoke-virtual {v1, v3}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_15a

    .line 444
    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v1, v3, v7}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1a7

    .line 446
    :cond_15a
    new-instance v3, Lkotlin/text/Regex;

    sget-object v12, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v3, v10, v12}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v15, 0x2

    invoke-static {v3, v10, v13, v15, v12}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 447
    .local v3, "mClose":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_1a6

    .line 448
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v10

    invoke-virtual {v0, v13, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v12

    invoke-virtual {v12}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v12

    invoke-virtual {v0, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    move-object v3, v9

    goto :goto_1a7

    .line 449
    :cond_1a6
    move-object v3, v0

    .line 443
    .end local v3  # "mClose":Lkotlin/text/MatchResult;
    :goto_1a7
    move-object v0, v3

    .line 451
    nop

    .end local v1  # "tgtVarRe":Lkotlin/text/Regex;
    .end local v6  # "fullTag":Ljava/lang/String;
    .end local v7  # "safe":Ljava/lang/String;
    .end local v16  # "m":Lkotlin/text/MatchResult;
    .end local v18  # "name":Ljava/lang/String;
    add-int/lit8 v5, v5, 0x1

    move-object/from16 v7, v17

    move-object/from16 v1, v25

    move-object/from16 v6, v26

    move-object/from16 v13, v27

    move-object/from16 v15, v28

    move/from16 v3, v29

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x1

    const/4 v12, 0x2

    goto/16 :goto_b7

    .line 455
    .end local v25  # "tgtGlobalN":Ljava/lang/String;
    .end local v26  # "varRe":Lkotlin/text/Regex;
    .end local v27  # "EXACT_VARS":Ljava/util/Set;
    .end local v28  # "srcGlobalN":Ljava/lang/String;
    .end local v29  # "tgE":I
    .local v1, "tgtGlobalN":Ljava/lang/String;
    .local v3, "tgE":I
    .local v6, "varRe":Lkotlin/text/Regex;
    .restart local v13  # "EXACT_VARS":Ljava/util/Set;
    .restart local v15  # "srcGlobalN":Ljava/lang/String;
    :cond_1bd
    move-object/from16 v25, v1

    move/from16 v29, v3

    move-object/from16 v26, v6

    move-object/from16 v27, v13

    move-object/from16 v28, v15

    .end local v1  # "tgtGlobalN":Ljava/lang/String;
    .end local v3  # "tgE":I
    .end local v6  # "varRe":Lkotlin/text/Regex;
    .end local v13  # "EXACT_VARS":Ljava/util/Set;
    .end local v15  # "srcGlobalN":Ljava/lang/String;
    .restart local v25  # "tgtGlobalN":Ljava/lang/String;
    .restart local v26  # "varRe":Lkotlin/text/Regex;
    .restart local v27  # "EXACT_VARS":Ljava/util/Set;
    .restart local v28  # "srcGlobalN":Ljava/lang/String;
    .restart local v29  # "tgE":I
    const/16 v21, 0x8

    const/16 v22, 0x0

    const-string v18, "<coupons"

    const-string v19, "</coupons>"

    const/16 v20, 0x0

    move-object/from16 v16, p0

    move-object/from16 v17, v4

    invoke-static/range {v16 .. v22}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 456
    .local v1, "srcCoupBlkN":Ljava/lang/String;
    if-eqz v1, :cond_33a

    .line 457
    move-object v3, v1

    .line 458
    .local v3, "srcCoupBlk":Ljava/lang/String;
    new-instance v6, Lkotlin/text/Regex;

    const-string v7, "<coupon\\b[^>]*\\bid=\"([^\"]*)\"[^>]*/>"

    invoke-direct {v6, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 459
    .local v6, "couponRe":Lkotlin/text/Regex;
    move-object v7, v3

    check-cast v7, Ljava/lang/CharSequence;

    move-object/from16 v16, v0

    const/4 v0, 0x2

    const/4 v13, 0x0

    const/4 v15, 0x0

    .end local v0  # "newGlobal":Ljava/lang/String;
    .local v16, "newGlobal":Ljava/lang/String;
    invoke-static {v6, v7, v15, v0, v13}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v7

    invoke-interface {v7}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v0

    move v7, v5

    move-object/from16 v5, v16

    .end local v16  # "newGlobal":Ljava/lang/String;
    .local v5, "newGlobal":Ljava/lang/String;
    .local v7, "copyCount":I
    :goto_1fc
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_32e

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lkotlin/text/MatchResult;

    .line 460
    .local v13, "cm":Lkotlin/text/MatchResult;
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v15

    move-object/from16 v17, v1

    const/4 v1, 0x1

    .end local v1  # "srcCoupBlkN":Ljava/lang/String;
    .local v17, "srcCoupBlkN":Ljava/lang/String;
    invoke-interface {v15, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 461
    .local v15, "cid":Ljava/lang/String;
    invoke-interface {v14, v15}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_31d

    .line 462
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v1

    .line 463
    .local v1, "fullCoup":Ljava/lang/String;
    move-object/from16 v18, v0

    invoke-static {v1}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 464
    .local v0, "safe":Ljava/lang/String;
    move-object/from16 v19, v3

    .end local v3  # "srcCoupBlk":Ljava/lang/String;
    .local v19, "srcCoupBlk":Ljava/lang/String;
    new-instance v3, Lkotlin/text/Regex;

    move-object/from16 v20, v6

    .end local v6  # "couponRe":Lkotlin/text/Regex;
    .local v20, "couponRe":Lkotlin/text/Regex;
    sget-object v6, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v6, v15}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v16, v13

    .end local v13  # "cm":Lkotlin/text/MatchResult;
    .local v16, "cm":Lkotlin/text/MatchResult;
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v21, v14

    .end local v14  # "COUPON_IDS":Ljava/util/Set;
    .local v21, "COUPON_IDS":Ljava/util/Set;
    const-string v14, "<coupon\\b[^>]*\\bid=\""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 465
    .local v3, "tgtCoupRe":Lkotlin/text/Regex;
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-virtual {v3, v6}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_269

    .line 466
    move-object v6, v5

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3, v6, v0}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v22, v0

    move-object/from16 v23, v3

    const/4 v14, 0x0

    goto/16 :goto_30d

    .line 468
    :cond_269
    move-object/from16 v30, v5

    check-cast v30, Ljava/lang/CharSequence;

    const/16 v34, 0x6

    const/16 v35, 0x0

    const-string v31, "</coupons>"

    const/16 v32, 0x0

    const/16 v33, 0x0

    invoke-static/range {v30 .. v35}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v6

    .line 469
    .local v6, "closeCoupIdx":I
    const/4 v13, -0x1

    if-eq v6, v13, :cond_2b3

    .line 470
    const/4 v13, 0x0

    invoke-virtual {v5, v13, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v5, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v22, v0

    .end local v0  # "safe":Ljava/lang/String;
    .local v22, "safe":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v14, "  "

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v6, v0

    move-object/from16 v23, v3

    const/4 v14, 0x0

    goto :goto_30d

    .line 472
    .end local v22  # "safe":Ljava/lang/String;
    .restart local v0  # "safe":Ljava/lang/String;
    :cond_2b3
    move-object/from16 v22, v0

    .end local v0  # "safe":Ljava/lang/String;
    .restart local v22  # "safe":Ljava/lang/String;
    new-instance v0, Lkotlin/text/Regex;

    sget-object v13, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v0, v10, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v13, v5

    check-cast v13, Ljava/lang/CharSequence;

    move-object/from16 v23, v3

    move/from16 v24, v6

    const/4 v3, 0x0

    const/4 v6, 0x2

    const/4 v14, 0x0

    .end local v3  # "tgtCoupRe":Lkotlin/text/Regex;
    .end local v6  # "closeCoupIdx":I
    .local v23, "tgtCoupRe":Lkotlin/text/Regex;
    .local v24, "closeCoupIdx":I
    invoke-static {v0, v13, v3, v6, v14}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 473
    .local v0, "mClose":Lkotlin/text/MatchResult;
    if-eqz v0, :cond_30c

    .line 474
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v13

    invoke-virtual {v13}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v13

    invoke-virtual {v5, v3, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    invoke-virtual {v5, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, "<coupons>\n  "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, "\n</coupons>\n"

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_30d

    .line 475
    :cond_30c
    move-object v6, v5

    .line 465
    .end local v0  # "mClose":Lkotlin/text/MatchResult;
    .end local v24  # "closeCoupIdx":I
    :goto_30d
    move-object v5, v6

    .line 478
    nop

    .end local v1  # "fullCoup":Ljava/lang/String;
    .end local v15  # "cid":Ljava/lang/String;
    .end local v16  # "cm":Lkotlin/text/MatchResult;
    .end local v22  # "safe":Ljava/lang/String;
    .end local v23  # "tgtCoupRe":Lkotlin/text/Regex;
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v1, v17

    move-object/from16 v0, v18

    move-object/from16 v3, v19

    move-object/from16 v6, v20

    move-object/from16 v14, v21

    goto/16 :goto_1fc

    .line 461
    .end local v19  # "srcCoupBlk":Ljava/lang/String;
    .end local v20  # "couponRe":Lkotlin/text/Regex;
    .end local v21  # "COUPON_IDS":Ljava/util/Set;
    .local v3, "srcCoupBlk":Ljava/lang/String;
    .local v6, "couponRe":Lkotlin/text/Regex;
    .restart local v13  # "cm":Lkotlin/text/MatchResult;
    .restart local v14  # "COUPON_IDS":Ljava/util/Set;
    .restart local v15  # "cid":Ljava/lang/String;
    :cond_31d
    move-object/from16 v18, v0

    move-object/from16 v19, v3

    move-object/from16 v20, v6

    move-object/from16 v16, v13

    move-object/from16 v21, v14

    const/4 v14, 0x0

    .end local v3  # "srcCoupBlk":Ljava/lang/String;
    .end local v6  # "couponRe":Lkotlin/text/Regex;
    .end local v13  # "cm":Lkotlin/text/MatchResult;
    .end local v14  # "COUPON_IDS":Ljava/util/Set;
    .restart local v16  # "cm":Lkotlin/text/MatchResult;
    .restart local v19  # "srcCoupBlk":Ljava/lang/String;
    .restart local v20  # "couponRe":Lkotlin/text/Regex;
    .restart local v21  # "COUPON_IDS":Ljava/util/Set;
    move-object/from16 v1, v17

    move-object/from16 v14, v21

    goto/16 :goto_1fc

    .line 459
    .end local v15  # "cid":Ljava/lang/String;
    .end local v16  # "cm":Lkotlin/text/MatchResult;
    .end local v17  # "srcCoupBlkN":Ljava/lang/String;
    .end local v19  # "srcCoupBlk":Ljava/lang/String;
    .end local v20  # "couponRe":Lkotlin/text/Regex;
    .end local v21  # "COUPON_IDS":Ljava/util/Set;
    .local v1, "srcCoupBlkN":Ljava/lang/String;
    .restart local v3  # "srcCoupBlk":Ljava/lang/String;
    .restart local v6  # "couponRe":Lkotlin/text/Regex;
    .restart local v14  # "COUPON_IDS":Ljava/util/Set;
    :cond_32e
    move-object/from16 v17, v1

    move-object/from16 v19, v3

    move-object/from16 v20, v6

    move-object/from16 v21, v14

    .end local v1  # "srcCoupBlkN":Ljava/lang/String;
    .end local v3  # "srcCoupBlk":Ljava/lang/String;
    .end local v6  # "couponRe":Lkotlin/text/Regex;
    .end local v14  # "COUPON_IDS":Ljava/util/Set;
    .restart local v17  # "srcCoupBlkN":Ljava/lang/String;
    .restart local v19  # "srcCoupBlk":Ljava/lang/String;
    .restart local v20  # "couponRe":Lkotlin/text/Regex;
    .restart local v21  # "COUPON_IDS":Ljava/util/Set;
    move-object/from16 v16, v5

    move v5, v7

    goto :goto_340

    .line 456
    .end local v7  # "copyCount":I
    .end local v17  # "srcCoupBlkN":Ljava/lang/String;
    .end local v19  # "srcCoupBlk":Ljava/lang/String;
    .end local v20  # "couponRe":Lkotlin/text/Regex;
    .end local v21  # "COUPON_IDS":Ljava/util/Set;
    .local v0, "newGlobal":Ljava/lang/String;
    .restart local v1  # "srcCoupBlkN":Ljava/lang/String;
    .local v5, "copyCount":I
    .restart local v14  # "COUPON_IDS":Ljava/util/Set;
    :cond_33a
    move-object/from16 v16, v0

    move-object/from16 v17, v1

    move-object/from16 v21, v14

    .line 483
    .end local v0  # "newGlobal":Ljava/lang/String;
    .end local v1  # "srcCoupBlkN":Ljava/lang/String;
    .end local v14  # "COUPON_IDS":Ljava/util/Set;
    .local v16, "newGlobal":Ljava/lang/String;
    .restart local v17  # "srcCoupBlkN":Ljava/lang/String;
    .restart local v21  # "COUPON_IDS":Ljava/util/Set;
    :goto_340
    sget-object v0, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    const-string v1, "WareHouseCashUpgrade"

    invoke-virtual {v0, v4, v1}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 484
    .local v1, "rawUpg":Ljava/lang/String;
    if-eqz v1, :cond_38f

    .line 485
    nop

    .line 486
    :try_start_34b
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0
    :try_end_34f
    .catch Ljava/lang/NumberFormatException; {:try_start_34b .. :try_end_34f} :catch_389

    .line 487
    .local v0, "newUpgrades":I
    move-object/from16 v3, p0

    :try_start_351
    invoke-direct {v3, v0}, Lcom/twntool/editor/core/DesbanEngine;->barnCalcWhudup(I)I

    move-result v6

    .line 488
    .local v6, "newWhudup":I
    const-string v33, "WareHouseCashUpgrade"

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v34

    const/16 v36, 0x8

    const/16 v37, 0x0

    const/16 v35, 0x0

    move-object/from16 v31, p0

    move-object/from16 v32, v16

    invoke-static/range {v31 .. v37}, Lcom/twntool/editor/core/DesbanEngine;->upsertVar$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v31
    :try_end_369
    .catch Ljava/lang/NumberFormatException; {:try_start_351 .. :try_end_369} :catch_387

    .line 489
    .end local v16  # "newGlobal":Ljava/lang/String;
    .local v31, "newGlobal":Ljava/lang/String;
    :try_start_369
    const-string v32, "WHUdup"

    invoke-static {v6}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v33

    const/16 v35, 0x8

    const/16 v36, 0x0

    const/16 v34, 0x0

    move-object/from16 v30, p0

    invoke-static/range {v30 .. v36}, Lcom/twntool/editor/core/DesbanEngine;->upsertVar$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v7
    :try_end_37b
    .catch Ljava/lang/NumberFormatException; {:try_start_369 .. :try_end_37b} :catch_383

    move-object/from16 v16, v7

    .line 490
    .end local v31  # "newGlobal":Ljava/lang/String;
    .restart local v16  # "newGlobal":Ljava/lang/String;
    nop

    .end local v0  # "newUpgrades":I
    .end local v6  # "newWhudup":I
    add-int/lit8 v5, v5, 0x1

    move-object/from16 v0, v16

    goto :goto_393

    .line 491
    .end local v16  # "newGlobal":Ljava/lang/String;
    .restart local v31  # "newGlobal":Ljava/lang/String;
    :catch_383
    move-exception v0

    move-object/from16 v16, v31

    goto :goto_38c

    .end local v31  # "newGlobal":Ljava/lang/String;
    .restart local v16  # "newGlobal":Ljava/lang/String;
    :catch_387
    move-exception v0

    goto :goto_38c

    :catch_389
    move-exception v0

    move-object/from16 v3, p0

    :goto_38c
    move-object/from16 v0, v16

    goto :goto_393

    .line 484
    :cond_38f
    move-object/from16 v3, p0

    move-object/from16 v0, v16

    .line 494
    .end local v16  # "newGlobal":Ljava/lang/String;
    .local v0, "newGlobal":Ljava/lang/String;
    :goto_393
    const/4 v6, 0x0

    invoke-virtual {v8, v6, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move/from16 v9, v29

    .end local v29  # "tgE":I
    .local v9, "tgE":I
    invoke-virtual {v8, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 495
    .local v7, "out":Ljava/lang/String;
    new-instance v10, Lkotlin/Triple;

    if-lez v5, :cond_3be

    const/4 v6, 0x1

    :cond_3be
    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "GlobalVars+Coupons: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " copiados"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v7, v6, v11}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v10
.end method

.method private final cloneMatch3AdvantagesBoosters(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 40
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 866
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "m3Line"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "m3Bomb"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string v1, "m3RainbowBall"

    const/4 v4, 0x2

    aput-object v1, v0, v4

    const-string v1, "m3Mallet"

    const/4 v5, 0x3

    aput-object v1, v0, v5

    .line 867
    const-string v1, "m3HorizontalLine"

    const/4 v6, 0x4

    aput-object v1, v0, v6

    .line 866
    nop

    .line 867
    const-string v1, "m3VerticalLine"

    const/4 v7, 0x5

    aput-object v1, v0, v7

    .line 866
    nop

    .line 867
    const-string v1, "m3Reshuffle"

    const/4 v8, 0x6

    aput-object v1, v0, v8

    .line 866
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 868
    .local v0, "M3_VARS":Ljava/util/List;
    new-array v1, v8, [Ljava/lang/String;

    const-string v8, "SP_BoostSpeedUpBuildings"

    aput-object v8, v1, v2

    const-string v8, "SP_BoostSpeedUpHarvest"

    aput-object v8, v1, v3

    .line 869
    const-string v8, "SP_BoostSpeedUpFarms"

    aput-object v8, v1, v4

    .line 868
    nop

    .line 869
    const-string v8, "SP_BoostStorageCapacity"

    aput-object v8, v1, v5

    .line 868
    nop

    .line 870
    const-string v5, "SP_BoostSpeedUpAir"

    aput-object v5, v1, v6

    .line 868
    nop

    .line 870
    const-string v5, "SP_BoostTrainMats"

    aput-object v5, v1, v7

    .line 868
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    .line 871
    .local v1, "SP_VARS":Ljava/util/List;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    check-cast v5, Ljava/util/List;

    .line 872
    .local v5, "info":Ljava/util/List;
    move-object/from16 v13, p2

    .line 875
    .local v13, "out":Ljava/lang/String;
    const/16 v11, 0x8

    const/4 v12, 0x0

    const-string v8, "<Global"

    const-string v9, "</Global>"

    const/4 v10, 0x0

    move-object/from16 v6, p0

    move-object/from16 v7, p1

    invoke-static/range {v6 .. v12}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v6

    move-object v14, v6

    check-cast v14, Ljava/lang/String;

    .line 876
    .local v14, "srcGlobalN":Ljava/lang/String;
    const-string v8, "<Global"

    const-string v9, "</Global>"

    move-object/from16 v6, p0

    move-object v7, v13

    invoke-static/range {v6 .. v12}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .local v7, "tgtGlobalN":Ljava/lang/String;
    invoke-virtual {v6}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Number;

    invoke-virtual {v8}, Ljava/lang/Number;->intValue()I

    move-result v8

    .local v8, "tgS":I
    invoke-virtual {v6}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Number;

    invoke-virtual {v6}, Ljava/lang/Number;->intValue()I

    move-result v6

    .line 877
    .local v6, "tgE":I
    const-string v9, "\n  "

    const-string v10, "Match-3: "

    const-string v11, "\"[^>]*/>"

    const-string v12, "<Var\\b[^>]*\\bname=\""

    const-string v3, "substring(...)"

    if-eqz v14, :cond_200

    if-eqz v7, :cond_200

    .line 878
    move-object/from16 v16, v14

    .line 879
    .local v16, "srcGlobal":Ljava/lang/String;
    move-object/from16 v17, v7

    .line 880
    .local v17, "newTgtGlobal":Ljava/lang/String;
    const/16 v18, 0x0

    .line 881
    .local v18, "m3Count":I
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v19

    move-object/from16 v20, v17

    move/from16 v21, v18

    .end local v17  # "newTgtGlobal":Ljava/lang/String;
    .end local v18  # "m3Count":I
    .local v20, "newTgtGlobal":Ljava/lang/String;
    .local v21, "m3Count":I
    :goto_ae
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v17

    if-eqz v17, :cond_1b3

    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v17

    move-object/from16 v2, v17

    check-cast v2, Ljava/lang/String;

    .line 882
    .local v2, "vname":Ljava/lang/String;
    new-instance v4, Lkotlin/text/Regex;

    sget-object v15, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v15, v2}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    move-object/from16 v22, v0

    .end local v0  # "M3_VARS":Ljava/util/List;
    .local v22, "M3_VARS":Ljava/util/List;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v4, v0}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, v16

    check-cast v0, Ljava/lang/CharSequence;

    move-object/from16 v23, v7

    move-object/from16 v24, v14

    const/4 v7, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    .end local v7  # "tgtGlobalN":Ljava/lang/String;
    .end local v14  # "srcGlobalN":Ljava/lang/String;
    .local v23, "tgtGlobalN":Ljava/lang/String;
    .local v24, "srcGlobalN":Ljava/lang/String;
    invoke-static {v4, v0, v7, v14, v15}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    if-nez v0, :cond_f8

    .line 883
    move-object/from16 v0, v22

    move-object/from16 v7, v23

    move-object/from16 v14, v24

    const/4 v2, 0x0

    const/4 v4, 0x2

    goto :goto_ae

    .line 884
    .local v0, "mSrc":Lkotlin/text/MatchResult;
    :cond_f8
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v4

    .line 885
    .local v4, "srcTag":Ljava/lang/String;
    invoke-static {v4}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 886
    .local v7, "safe":Ljava/lang/String;
    new-instance v14, Lkotlin/text/Regex;

    sget-object v15, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v15, v2}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    move-object/from16 v25, v0

    .end local v0  # "mSrc":Lkotlin/text/MatchResult;
    .local v25, "mSrc":Lkotlin/text/MatchResult;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v14, v0}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v0, v14

    .line 887
    .local v0, "pat":Lkotlin/text/Regex;
    move-object/from16 v14, v20

    .end local v20  # "newTgtGlobal":Ljava/lang/String;
    .local v14, "newTgtGlobal":Ljava/lang/String;
    move-object v15, v14

    check-cast v15, Ljava/lang/CharSequence;

    invoke-virtual {v0, v15}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v15

    if-eqz v15, :cond_143

    .line 888
    move-object v15, v14

    check-cast v15, Ljava/lang/CharSequence;

    invoke-static {v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, v15, v7}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v20

    move-object/from16 v26, v2

    move-object/from16 v27, v7

    move-object/from16 v28, v11

    move-object/from16 v2, v20

    move-object/from16 v20, v0

    goto :goto_19f

    .line 890
    :cond_143
    new-instance v15, Lkotlin/text/Regex;

    move-object/from16 v20, v0

    .end local v0  # "pat":Lkotlin/text/Regex;
    .local v20, "pat":Lkotlin/text/Regex;
    const-string v0, "</Global\\s*>"

    move-object/from16 v26, v2

    .end local v2  # "vname":Ljava/lang/String;
    .local v26, "vname":Ljava/lang/String;
    sget-object v2, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v15, v0, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v0, v14

    check-cast v0, Ljava/lang/CharSequence;

    move-object/from16 v27, v7

    move-object/from16 v28, v11

    const/4 v2, 0x0

    const/4 v7, 0x0

    const/4 v11, 0x2

    .end local v7  # "safe":Ljava/lang/String;
    .local v27, "safe":Ljava/lang/String;
    invoke-static {v15, v0, v7, v11, v2}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 891
    .local v0, "mClose":Lkotlin/text/MatchResult;
    if-eqz v0, :cond_19e

    .line 892
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v2

    invoke-virtual {v14, v7, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {v14, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v11, "    "

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_19f

    .line 893
    :cond_19e
    move-object v2, v14

    .line 887
    .end local v0  # "mClose":Lkotlin/text/MatchResult;
    :goto_19f
    move-object v0, v2

    .line 895
    .end local v14  # "newTgtGlobal":Ljava/lang/String;
    .local v0, "newTgtGlobal":Ljava/lang/String;
    nop

    .end local v4  # "srcTag":Ljava/lang/String;
    .end local v20  # "pat":Lkotlin/text/Regex;
    .end local v25  # "mSrc":Lkotlin/text/MatchResult;
    .end local v26  # "vname":Ljava/lang/String;
    .end local v27  # "safe":Ljava/lang/String;
    move/from16 v2, v21

    .end local v21  # "m3Count":I
    .local v2, "m3Count":I
    add-int/lit8 v21, v2, 0x1

    move-object/from16 v20, v0

    move-object/from16 v0, v22

    move-object/from16 v7, v23

    move-object/from16 v14, v24

    move-object/from16 v11, v28

    const/4 v2, 0x0

    const/4 v4, 0x2

    .end local v2  # "m3Count":I
    .restart local v21  # "m3Count":I
    goto/16 :goto_ae

    .line 897
    .end local v22  # "M3_VARS":Ljava/util/List;
    .end local v23  # "tgtGlobalN":Ljava/lang/String;
    .end local v24  # "srcGlobalN":Ljava/lang/String;
    .local v0, "M3_VARS":Ljava/util/List;
    .local v7, "tgtGlobalN":Ljava/lang/String;
    .local v14, "srcGlobalN":Ljava/lang/String;
    .local v20, "newTgtGlobal":Ljava/lang/String;
    :cond_1b3
    move-object/from16 v22, v0

    move-object/from16 v23, v7

    move-object/from16 v28, v11

    move-object/from16 v24, v14

    move-object/from16 v14, v20

    move/from16 v2, v21

    .end local v0  # "M3_VARS":Ljava/util/List;
    .end local v7  # "tgtGlobalN":Ljava/lang/String;
    .end local v20  # "newTgtGlobal":Ljava/lang/String;
    .end local v21  # "m3Count":I
    .restart local v2  # "m3Count":I
    .local v14, "newTgtGlobal":Ljava/lang/String;
    .restart local v22  # "M3_VARS":Ljava/util/List;
    .restart local v23  # "tgtGlobalN":Ljava/lang/String;
    .restart local v24  # "srcGlobalN":Ljava/lang/String;
    if-lez v2, :cond_208

    .line 898
    const/4 v0, 0x0

    invoke-virtual {v13, v0, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v13, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 899
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " vars"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v5, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_208

    .line 877
    .end local v2  # "m3Count":I
    .end local v16  # "srcGlobal":Ljava/lang/String;
    .end local v22  # "M3_VARS":Ljava/util/List;
    .end local v23  # "tgtGlobalN":Ljava/lang/String;
    .end local v24  # "srcGlobalN":Ljava/lang/String;
    .restart local v0  # "M3_VARS":Ljava/util/List;
    .restart local v7  # "tgtGlobalN":Ljava/lang/String;
    .local v14, "srcGlobalN":Ljava/lang/String;
    :cond_200
    move-object/from16 v22, v0

    move-object/from16 v23, v7

    move-object/from16 v28, v11

    move-object/from16 v24, v14

    .line 915
    .end local v0  # "M3_VARS":Ljava/util/List;
    .end local v7  # "tgtGlobalN":Ljava/lang/String;
    .end local v14  # "srcGlobalN":Ljava/lang/String;
    .restart local v22  # "M3_VARS":Ljava/util/List;
    .restart local v23  # "tgtGlobalN":Ljava/lang/String;
    .restart local v24  # "srcGlobalN":Ljava/lang/String;
    :cond_208
    :goto_208
    invoke-static/range {p1 .. p1}, Lcom/twntool/editor/core/DesbanEngine;->cloneMatch3AdvantagesBoosters$findSeasonTicket(Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    .line 916
    .local v0, "srcSt":Lkotlin/Triple;
    invoke-static {v13}, Lcom/twntool/editor/core/DesbanEngine;->cloneMatch3AdvantagesBoosters$findSeasonTicket(Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v2

    .line 917
    .local v2, "tgtSt":Lkotlin/Triple;
    if-eqz v0, :cond_3d7

    if-eqz v2, :cond_3d7

    .line 918
    invoke-virtual {v2}, Lkotlin/Triple;->getThird()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 919
    .local v4, "newTgtSt":Ljava/lang/String;
    const/4 v7, 0x0

    .line 920
    .local v7, "spCount":I
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_21f
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_37e

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .line 921
    .local v14, "vname":Ljava/lang/String;
    new-instance v15, Lkotlin/text/Regex;

    move-object/from16 v16, v1

    .end local v1  # "SP_VARS":Ljava/util/List;
    .local v16, "SP_VARS":Ljava/util/List;
    sget-object v1, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v1, v14}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move/from16 v19, v6

    .end local v6  # "tgE":I
    .local v19, "tgE":I
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v6, v28

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v15, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lkotlin/Triple;->getThird()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    move-object/from16 v20, v0

    move/from16 v21, v8

    move-object/from16 v25, v11

    const/4 v0, 0x0

    const/4 v8, 0x0

    const/4 v11, 0x2

    .end local v0  # "srcSt":Lkotlin/Triple;
    .end local v8  # "tgS":I
    .local v20, "srcSt":Lkotlin/Triple;
    .local v21, "tgS":I
    invoke-static {v15, v1, v8, v11, v0}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    if-nez v1, :cond_273

    .line 922
    move-object/from16 v28, v6

    move-object/from16 v1, v16

    move/from16 v6, v19

    move-object/from16 v0, v20

    move/from16 v8, v21

    move-object/from16 v11, v25

    goto :goto_21f

    .line 921
    :cond_273
    move-object v0, v1

    .line 923
    .local v0, "mSrc":Lkotlin/text/MatchResult;
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v1

    .line 924
    .local v1, "srcTag":Ljava/lang/String;
    invoke-static {v1}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 925
    .local v8, "safe":Ljava/lang/String;
    new-instance v11, Lkotlin/text/Regex;

    sget-object v15, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v15, v14}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    move-object/from16 v26, v0

    .end local v0  # "mSrc":Lkotlin/text/MatchResult;
    .local v26, "mSrc":Lkotlin/text/MatchResult;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v11, v0}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v0, v11

    .line 926
    .local v0, "pat":Lkotlin/text/Regex;
    move-object v11, v4

    check-cast v11, Ljava/lang/CharSequence;

    invoke-virtual {v0, v11}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v11

    if-eqz v11, :cond_2ba

    .line 927
    move-object v11, v4

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, v11, v8}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    move-object/from16 v27, v0

    move-object/from16 v28, v6

    move-object/from16 v29, v8

    goto/16 :goto_36e

    .line 929
    :cond_2ba
    new-instance v11, Lkotlin/text/Regex;

    const-string v15, "<Vars\\s*/>"

    invoke-direct {v11, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v15, v4

    check-cast v15, Ljava/lang/CharSequence;

    move-object/from16 v27, v0

    move-object/from16 v28, v6

    move-object/from16 v29, v8

    const/4 v0, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x2

    .end local v0  # "pat":Lkotlin/text/Regex;
    .end local v8  # "safe":Ljava/lang/String;
    .local v27, "pat":Lkotlin/text/Regex;
    .local v29, "safe":Ljava/lang/String;
    invoke-static {v11, v15, v6, v8, v0}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v11

    .line 930
    .local v11, "mVsc":Lkotlin/text/MatchResult;
    if-eqz v11, :cond_317

    .line 931
    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v0

    invoke-virtual {v4, v6, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 932
    nop

    .line 933
    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v6

    const/4 v8, 0x1

    add-int/2addr v6, v8

    invoke-virtual {v4, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v8, "<Vars>\n        "

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v8, "\n      </Vars>"

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v11, v0

    goto :goto_36e

    .line 935
    :cond_317
    new-instance v0, Lkotlin/text/Regex;

    const-string v6, "</Vars\\s*>"

    invoke-direct {v0, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v6, v4

    check-cast v6, Ljava/lang/CharSequence;

    move-object/from16 v30, v11

    const/4 v8, 0x0

    const/4 v11, 0x2

    const/4 v15, 0x0

    .end local v11  # "mVsc":Lkotlin/text/MatchResult;
    .local v30, "mVsc":Lkotlin/text/MatchResult;
    invoke-static {v0, v6, v15, v11, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 936
    .local v0, "mClose":Lkotlin/text/MatchResult;
    if-eqz v0, :cond_36d

    .line 937
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v4, v15, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 938
    nop

    .line 939
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {v4, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v11, "        "

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v11, "\n      "

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    goto :goto_36e

    .line 940
    :cond_36d
    move-object v11, v4

    .line 926
    .end local v0  # "mClose":Lkotlin/text/MatchResult;
    .end local v30  # "mVsc":Lkotlin/text/MatchResult;
    :goto_36e
    move-object v4, v11

    .line 943
    nop

    .end local v1  # "srcTag":Ljava/lang/String;
    .end local v14  # "vname":Ljava/lang/String;
    .end local v26  # "mSrc":Lkotlin/text/MatchResult;
    .end local v27  # "pat":Lkotlin/text/Regex;
    .end local v29  # "safe":Ljava/lang/String;
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v1, v16

    move/from16 v6, v19

    move-object/from16 v0, v20

    move/from16 v8, v21

    move-object/from16 v11, v25

    goto/16 :goto_21f

    .line 945
    .end local v16  # "SP_VARS":Ljava/util/List;
    .end local v19  # "tgE":I
    .end local v20  # "srcSt":Lkotlin/Triple;
    .end local v21  # "tgS":I
    .local v0, "srcSt":Lkotlin/Triple;
    .local v1, "SP_VARS":Ljava/util/List;
    .restart local v6  # "tgE":I
    .local v8, "tgS":I
    :cond_37e
    move-object/from16 v20, v0

    move-object/from16 v16, v1

    move/from16 v19, v6

    move/from16 v21, v8

    .end local v0  # "srcSt":Lkotlin/Triple;
    .end local v1  # "SP_VARS":Ljava/util/List;
    .end local v6  # "tgE":I
    .end local v8  # "tgS":I
    .restart local v16  # "SP_VARS":Ljava/util/List;
    .restart local v19  # "tgE":I
    .restart local v20  # "srcSt":Lkotlin/Triple;
    .restart local v21  # "tgS":I
    if-lez v7, :cond_3df

    .line 946
    invoke-virtual {v2}, Lkotlin/Triple;->getFirst()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {v13, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2}, Lkotlin/Triple;->getSecond()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v1

    invoke-virtual {v13, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 947
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "SP boosts: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v5, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3df

    .line 917
    .end local v4  # "newTgtSt":Ljava/lang/String;
    .end local v7  # "spCount":I
    .end local v16  # "SP_VARS":Ljava/util/List;
    .end local v19  # "tgE":I
    .end local v20  # "srcSt":Lkotlin/Triple;
    .end local v21  # "tgS":I
    .restart local v0  # "srcSt":Lkotlin/Triple;
    .restart local v1  # "SP_VARS":Ljava/util/List;
    .restart local v6  # "tgE":I
    .restart local v8  # "tgS":I
    :cond_3d7
    move-object/from16 v20, v0

    move-object/from16 v16, v1

    move/from16 v19, v6

    move/from16 v21, v8

    .line 952
    .end local v0  # "srcSt":Lkotlin/Triple;
    .end local v1  # "SP_VARS":Ljava/util/List;
    .end local v6  # "tgE":I
    .end local v8  # "tgS":I
    .restart local v16  # "SP_VARS":Ljava/util/List;
    .restart local v19  # "tgE":I
    .restart local v20  # "srcSt":Lkotlin/Triple;
    .restart local v21  # "tgS":I
    :cond_3df
    :goto_3df
    const/16 v30, 0x8

    const/16 v31, 0x0

    const-string v27, "<Minigames"

    const-string v28, "</Minigames>"

    const/16 v29, 0x0

    move-object/from16 v25, p0

    move-object/from16 v26, p1

    invoke-static/range {v25 .. v31}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 953
    .local v0, "srcMg":Ljava/lang/String;
    const-string v27, "<Minigames"

    const-string v28, "</Minigames>"

    move-object/from16 v26, v13

    invoke-static/range {v25 .. v31}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .local v4, "tgtMg":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Number;

    invoke-virtual {v6}, Ljava/lang/Number;->intValue()I

    move-result v6

    .local v6, "tgMs":I
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v1

    .line 954
    .local v1, "tgMe":I
    if-eqz v0, :cond_48b

    if-eqz v4, :cond_48b

    .line 955
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "<Var\\b[^>]*\\bname=\"Lives_infTime_Match3\"[^>]*/>"

    invoke-direct {v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v11, v0

    check-cast v11, Ljava/lang/CharSequence;

    const/4 v12, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x2

    invoke-static {v7, v11, v14, v15, v12}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 956
    .local v7, "mSrcLiv":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_486

    .line 957
    invoke-interface {v7}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v11

    .line 958
    .local v11, "srcTag":Ljava/lang/String;
    invoke-static {v11}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 959
    .local v12, "safe":Ljava/lang/String;
    new-instance v14, Lkotlin/text/Regex;

    invoke-direct {v14, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v8, v14

    .line 960
    .local v8, "pat":Lkotlin/text/Regex;
    move-object v14, v4

    check-cast v14, Ljava/lang/CharSequence;

    invoke-virtual {v8, v14}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v14

    if-eqz v14, :cond_481

    .line 961
    move-object v14, v4

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v8, v14, v12}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 962
    .local v14, "newMg":Ljava/lang/String;
    move-object/from16 v25, v0

    const/4 v15, 0x0

    .end local v0  # "srcMg":Ljava/lang/String;
    .local v25, "srcMg":Ljava/lang/String;
    invoke-virtual {v13, v15, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v13, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move/from16 v26, v1

    .end local v1  # "tgMe":I
    .local v26, "tgMe":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 963
    const-string v0, "Vida Inf: ok"

    invoke-interface {v5, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .end local v14  # "newMg":Ljava/lang/String;
    goto :goto_48f

    .line 960
    .end local v25  # "srcMg":Ljava/lang/String;
    .end local v26  # "tgMe":I
    .restart local v0  # "srcMg":Ljava/lang/String;
    .restart local v1  # "tgMe":I
    :cond_481
    move-object/from16 v25, v0

    move/from16 v26, v1

    .end local v0  # "srcMg":Ljava/lang/String;
    .end local v1  # "tgMe":I
    .restart local v25  # "srcMg":Ljava/lang/String;
    .restart local v26  # "tgMe":I
    goto :goto_48f

    .line 956
    .end local v8  # "pat":Lkotlin/text/Regex;
    .end local v11  # "srcTag":Ljava/lang/String;
    .end local v12  # "safe":Ljava/lang/String;
    .end local v25  # "srcMg":Ljava/lang/String;
    .end local v26  # "tgMe":I
    .restart local v0  # "srcMg":Ljava/lang/String;
    .restart local v1  # "tgMe":I
    :cond_486
    move-object/from16 v25, v0

    move/from16 v26, v1

    .end local v0  # "srcMg":Ljava/lang/String;
    .end local v1  # "tgMe":I
    .restart local v25  # "srcMg":Ljava/lang/String;
    .restart local v26  # "tgMe":I
    goto :goto_48f

    .line 954
    .end local v7  # "mSrcLiv":Lkotlin/text/MatchResult;
    .end local v25  # "srcMg":Ljava/lang/String;
    .end local v26  # "tgMe":I
    .restart local v0  # "srcMg":Ljava/lang/String;
    .restart local v1  # "tgMe":I
    :cond_48b
    move-object/from16 v25, v0

    move/from16 v26, v1

    .line 969
    .end local v0  # "srcMg":Ljava/lang/String;
    .end local v1  # "tgMe":I
    .restart local v25  # "srcMg":Ljava/lang/String;
    .restart local v26  # "tgMe":I
    :goto_48f
    const/16 v32, 0x8

    const/16 v33, 0x0

    const-string v29, "<TimedEntityManager"

    const-string v30, "</TimedEntityManager>"

    const/16 v31, 0x0

    move-object/from16 v27, p0

    move-object/from16 v28, p1

    invoke-static/range {v27 .. v33}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->getFirst()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v1, "<TimedEntityManager\\b[^>]*?/>"

    if-nez v0, :cond_4c3

    .line 970
    new-instance v0, Lkotlin/text/Regex;

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object/from16 v7, p1

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v8, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x2

    invoke-static {v0, v7, v11, v12, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    if-eqz v0, :cond_4c2

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v0

    goto :goto_4c3

    :cond_4c2
    const/4 v0, 0x0

    .line 969
    :cond_4c3
    :goto_4c3
    nop

    .line 971
    .local v0, "srcTem":Ljava/lang/String;
    if-eqz v0, :cond_5db

    .line 972
    const/16 v32, 0x8

    const/16 v33, 0x0

    const-string v29, "<TimedEntityManager"

    const-string v30, "</TimedEntityManager>"

    const/16 v31, 0x0

    move-object/from16 v27, p0

    move-object/from16 v28, v13

    invoke-static/range {v27 .. v33}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .local v8, "tgtTem":Ljava/lang/String;
    invoke-virtual {v7}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Number;

    invoke-virtual {v11}, Ljava/lang/Number;->intValue()I

    move-result v11

    .local v11, "ts":I
    invoke-virtual {v7}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Number;

    invoke-virtual {v7}, Ljava/lang/Number;->intValue()I

    move-result v7

    .line 973
    .local v7, "te":I
    if-eqz v8, :cond_51c

    .line 974
    const/4 v1, 0x0

    invoke-virtual {v13, v1, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v13, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object/from16 v27, v2

    goto/16 :goto_5d4

    .line 976
    :cond_51c
    new-instance v12, Lkotlin/text/Regex;

    invoke-direct {v12, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, v13

    check-cast v1, Ljava/lang/CharSequence;

    move-object/from16 v27, v2

    const/4 v2, 0x2

    const/4 v14, 0x0

    const/4 v15, 0x0

    .end local v2  # "tgtSt":Lkotlin/Triple;
    .local v27, "tgtSt":Lkotlin/Triple;
    invoke-static {v12, v1, v15, v2, v14}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 977
    .local v1, "mSc":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_566

    .line 978
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v2

    invoke-virtual {v13, v15, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v9

    const/4 v12, 0x1

    add-int/2addr v9, v12

    invoke-virtual {v13, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v1, v2

    goto :goto_5d4

    .line 980
    :cond_566
    new-instance v2, Lkotlin/text/Regex;

    const-string v12, "</root\\s*>"

    sget-object v14, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v2, v12, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v12, v13

    check-cast v12, Ljava/lang/CharSequence;

    move-object/from16 v17, v1

    const/4 v1, 0x2

    const/4 v14, 0x0

    const/4 v15, 0x0

    .end local v1  # "mSc":Lkotlin/text/MatchResult;
    .local v17, "mSc":Lkotlin/text/MatchResult;
    invoke-static {v2, v12, v15, v1, v14}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 981
    .local v1, "mR":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_5be

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v2

    invoke-virtual {v13, v15, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v9

    invoke-virtual {v13, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v1, v2

    goto :goto_5d4

    .line 982
    :cond_5be
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v1, v2

    .line 973
    .end local v1  # "mR":Lkotlin/text/MatchResult;
    .end local v17  # "mSc":Lkotlin/text/MatchResult;
    :goto_5d4
    move-object v13, v1

    .line 985
    const-string v1, "Booster 2x: ok"

    invoke-interface {v5, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .end local v7  # "te":I
    .end local v8  # "tgtTem":Ljava/lang/String;
    .end local v11  # "ts":I
    goto :goto_5dd

    .line 971
    .end local v27  # "tgtSt":Lkotlin/Triple;
    .restart local v2  # "tgtSt":Lkotlin/Triple;
    :cond_5db
    move-object/from16 v27, v2

    .line 988
    .end local v2  # "tgtSt":Lkotlin/Triple;
    .restart local v27  # "tgtSt":Lkotlin/Triple;
    :goto_5dd
    invoke-interface {v5}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_5f2

    new-instance v1, Lkotlin/Triple;

    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    const-string v3, "Match-3/Vantagens/Booster: nada copiado"

    move-object/from16 v7, p2

    invoke-direct {v1, v7, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_62b

    .line 989
    :cond_5f2
    move-object/from16 v7, p2

    new-instance v1, Lkotlin/Triple;

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    move-object/from16 v28, v5

    check-cast v28, Ljava/lang/Iterable;

    const-string v3, " | "

    move-object/from16 v29, v3

    check-cast v29, Ljava/lang/CharSequence;

    const/16 v35, 0x3e

    const/16 v36, 0x0

    const/16 v30, 0x0

    const/16 v31, 0x0

    const/16 v32, 0x0

    const/16 v33, 0x0

    const/16 v34, 0x0

    invoke-static/range {v28 .. v36}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v13, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 988
    :goto_62b
    return-object v1
.end method

.method private static final cloneMatch3AdvantagesBoosters$findSeasonTicket(Ljava/lang/String;)Lkotlin/Triple;
    .registers 11
    .param p0, "xml"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 905
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "<SeasonTicket\\b"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, p0

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v0

    invoke-interface {v0}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_15
    :goto_15
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_90

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lkotlin/text/MatchResult;

    .line 906
    .local v1, "m":Lkotlin/text/MatchResult;
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    add-int/lit8 v5, v5, -0x4

    invoke-static {v2, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {p0, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v6, "substring(...)"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 907
    .local v5, "ctx":Ljava/lang/String;
    const-string v7, "Prev"

    invoke-static {v5, v7, v2, v3, v4}, Lkotlin/text/StringsKt;->endsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_15

    .line 908
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "</SeasonTicket\\s*>"

    invoke-direct {v7, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {p0, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v7, v8, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    if-nez v7, :cond_67

    goto :goto_15

    :cond_67
    move-object v0, v7

    .line 909
    .local v0, "endM":Lkotlin/text/MatchResult;
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v2

    .line 910
    .local v2, "s":I
    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v3

    add-int/2addr v3, v2

    add-int/lit8 v3, v3, 0x1

    .line 911
    .local v3, "e":I
    new-instance v4, Lkotlin/Triple;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {p0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v4, v7, v8, v9}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v4

    .line 913
    .end local v0  # "endM":Lkotlin/text/MatchResult;
    .end local v1  # "m":Lkotlin/text/MatchResult;
    .end local v2  # "s":I
    .end local v3  # "e":I
    .end local v5  # "ctx":Ljava/lang/String;
    :cond_90
    return-object v4
.end method

.method private final cloneTownAndBuildings(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 18
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 373
    new-instance v14, Lcom/twntool/editor/core/CloneEngine$CloneOptions;

    .line 374
    nop

    .line 373
    nop

    .line 374
    nop

    .line 375
    nop

    .line 373
    const/4 v12, 0x6

    const/4 v13, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    move-object v0, v14

    invoke-direct/range {v0 .. v13}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;-><init>(ZZZZZZZZZZZILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 377
    .local v0, "opts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    sget-object v1, Lcom/twntool/editor/core/CloneEngine;->INSTANCE:Lcom/twntool/editor/core/CloneEngine;

    move-object/from16 v2, p1

    move-object/from16 v3, p2

    invoke-virtual {v1, v2, v3, v0}, Lcom/twntool/editor/core/CloneEngine;->cloneDecoration(Ljava/lang/String;Ljava/lang/String;Lcom/twntool/editor/core/CloneEngine$CloneOptions;)Lcom/twntool/editor/core/CloneEngine$CloneResult;

    move-result-object v1

    .line 378
    .local v1, "r":Lcom/twntool/editor/core/CloneEngine$CloneResult;
    new-instance v4, Lkotlin/Triple;

    invoke-virtual {v1}, Lcom/twntool/editor/core/CloneEngine$CloneResult;->getXml()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1}, Lcom/twntool/editor/core/CloneEngine$CloneResult;->getOk()Z

    move-result v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v1}, Lcom/twntool/editor/core/CloneEngine$CloneResult;->getOk()Z

    move-result v7

    if-eqz v7, :cond_38

    const-string v7, "TownGround+Buildings: clonados"

    goto :goto_3a

    :cond_38
    const-string v7, "TownGround+Buildings: falhou"

    :goto_3a
    invoke-direct {v4, v5, v6, v7}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v4
.end method

.method private final cloneUpgradeBlock(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 19
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 329
    move-object/from16 v0, p2

    move-object/from16 v1, p0

    check-cast v1, Lcom/twntool/editor/core/DesbanEngine;

    .local v1, "$this$cloneUpgradeBlock_u24lambda_u240":Lcom/twntool/editor/core/DesbanEngine;
    const/4 v2, 0x0

    .line 330
    .local v2, "$i$a$-run-DesbanEngine$cloneUpgradeBlock$srcBlock$1":I
    new-instance v3, Lkotlin/text/Regex;

    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    const-string v5, "<Upgrade\\b[^>]*>.*?</Upgrade>"

    invoke-direct {v3, v5, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 331
    .local v3, "rxFull":Lkotlin/text/Regex;
    move-object/from16 v4, p1

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v3, v4, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 332
    .local v4, "mFull":Lkotlin/text/MatchResult;
    const-string v9, "<Upgrade\\b[^>]*/>"

    const/4 v10, 0x1

    .line 354
    invoke-static {v10}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v11

    .line 332
    if-eqz v4, :cond_29

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v10

    goto :goto_96

    .line 334
    :cond_29
    new-instance v12, Lkotlin/text/Regex;

    invoke-direct {v12, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 335
    .local v12, "rxSelf":Lkotlin/text/Regex;
    move-object/from16 v13, p1

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v12, v13, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v13

    .line 336
    .local v13, "mSelf":Lkotlin/text/MatchResult;
    if-eqz v13, :cond_95

    .line 338
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v14

    .line 339
    const-string v15, "<Upgrade"

    check-cast v15, Ljava/lang/CharSequence;

    invoke-static {v14, v15}, Lkotlin/text/StringsKt;->removePrefix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v14

    const-string v15, "/>"

    check-cast v15, Ljava/lang/CharSequence;

    invoke-static {v14, v15}, Lkotlin/text/StringsKt;->removeSuffix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v14

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v14}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v14

    .line 338
    nop

    .line 340
    .local v14, "attrs":Ljava/lang/String;
    move-object v15, v14

    check-cast v15, Ljava/lang/CharSequence;

    invoke-interface {v15}, Ljava/lang/CharSequence;->length()I

    move-result v15

    if-lez v15, :cond_61

    goto :goto_62

    :cond_61
    move v10, v6

    :goto_62
    if-eqz v10, :cond_7e

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "<Upgrade "

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v15, ">"

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    goto :goto_80

    :cond_7e
    const-string v10, "<Upgrade>"

    .line 341
    .local v10, "open":Ljava/lang/String;
    :goto_80
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v7, "</Upgrade>"

    invoke-virtual {v15, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    move-object v10, v7

    goto :goto_96

    .line 343
    .end local v10  # "open":Ljava/lang/String;
    .end local v14  # "attrs":Ljava/lang/String;
    :cond_95
    move-object v10, v8

    .line 329
    .end local v1  # "$this$cloneUpgradeBlock_u24lambda_u240":Lcom/twntool/editor/core/DesbanEngine;
    .end local v2  # "$i$a$-run-DesbanEngine$cloneUpgradeBlock$srcBlock$1":I
    .end local v3  # "rxFull":Lkotlin/text/Regex;
    .end local v4  # "mFull":Lkotlin/text/MatchResult;
    .end local v12  # "rxSelf":Lkotlin/text/Regex;
    .end local v13  # "mSelf":Lkotlin/text/MatchResult;
    :goto_96
    move-object v1, v10

    .line 345
    .local v1, "srcBlock":Ljava/lang/String;
    if-nez v1, :cond_a5

    new-instance v2, Lkotlin/Triple;

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const-string v4, "Upgrade: não encontrado no doador"

    invoke-direct {v2, v0, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v2

    .line 348
    :cond_a5
    new-instance v2, Lkotlin/text/Regex;

    sget-object v3, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v2, v5, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 349
    .local v2, "rxFullTgt":Lkotlin/text/Regex;
    new-instance v3, Lkotlin/text/Regex;

    invoke-direct {v3, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 350
    .local v3, "rxSelfTgt":Lkotlin/text/Regex;
    invoke-static {v1}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 352
    .local v4, "safe":Ljava/lang/String;
    nop

    .line 353
    move-object v5, v0

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v2, v5}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_d2

    .line 354
    new-instance v5, Lkotlin/Triple;

    move-object v6, v0

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2, v6, v4}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "Upgrade: substituído (body)"

    invoke-direct {v5, v6, v11, v7}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto/16 :goto_185

    .line 355
    :cond_d2
    move-object v5, v0

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v3, v5}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_ee

    .line 356
    new-instance v5, Lkotlin/Triple;

    move-object v6, v0

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3, v6, v4}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "Upgrade: expandido (self-closing → body)"

    invoke-direct {v5, v6, v11, v7}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto/16 :goto_185

    .line 358
    :cond_ee
    new-instance v5, Lkotlin/text/Regex;

    const-string v7, "</Global\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v5, v7, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v9, 0x2

    invoke-static {v5, v7, v6, v9, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    .line 359
    .local v5, "mG":Lkotlin/text/MatchResult;
    new-instance v7, Lkotlin/text/Regex;

    const-string v10, "</root\\s*>"

    sget-object v12, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v7, v10, v12}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v7, v10, v6, v9, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 360
    .local v7, "mR":Lkotlin/text/MatchResult;
    if-eqz v5, :cond_120

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    if-eqz v9, :cond_120

    :goto_117
    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    goto :goto_129

    :cond_120
    if-eqz v7, :cond_129

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    if-eqz v9, :cond_129

    goto :goto_117

    .line 361
    .local v8, "insertAt":Ljava/lang/Integer;
    :cond_129
    :goto_129
    const-string v9, "\n"

    if-eqz v8, :cond_168

    .line 362
    new-instance v10, Lkotlin/Triple;

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v12

    invoke-virtual {v0, v6, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    const-string v12, "substring(...)"

    invoke-static {v6, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-virtual {v0, v13}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 363
    nop

    .line 362
    const-string v9, "Upgrade: inserido"

    invoke-direct {v10, v6, v11, v9}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    move-object v5, v10

    goto :goto_185

    .line 365
    :cond_168
    new-instance v6, Lkotlin/Triple;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const-string v10, "Upgrade: appended"

    invoke-direct {v6, v9, v11, v10}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    move-object v5, v6

    .line 352
    .end local v5  # "mG":Lkotlin/text/MatchResult;
    .end local v7  # "mR":Lkotlin/text/MatchResult;
    .end local v8  # "insertAt":Ljava/lang/Integer;
    :goto_185
    return-object v5
.end method

.method private final cloneXmlBlockPair(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 33
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .param p3, "open1"  # Ljava/lang/String;
    .param p4, "close1"  # Ljava/lang/String;
    .param p5, "open2"  # Ljava/lang/String;
    .param p6, "close2"  # Ljava/lang/String;
    .param p7, "label"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 270
    move-object/from16 v0, p2

    .line 271
    .local v0, "out":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "ok1":Z
    const/4 v2, 0x0

    .line 273
    .local v2, "ok2":Z
    const/16 v8, 0x8

    const/4 v9, 0x0

    const/4 v7, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move-object/from16 v5, p3

    move-object/from16 v6, p4

    invoke-static/range {v3 .. v9}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 274
    .local v3, "b1":Ljava/lang/String;
    const-string v4, "\n"

    const/4 v6, 0x2

    const-string v7, "</Global\\s*>"

    const-string v8, ".*?"

    const-string v9, "substring(...)"

    const/4 v10, 0x0

    if-eqz v3, :cond_bd

    .line 275
    new-instance v11, Lkotlin/text/Regex;

    sget-object v12, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v13, p3

    invoke-virtual {v12, v13}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    sget-object v14, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v15, p4

    invoke-virtual {v14, v15}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sget-object v12, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v11, v5, v12}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v5, v11

    .line 276
    .local v5, "tgtRe":Lkotlin/text/Regex;
    invoke-static {v3}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 277
    .local v11, "safe1":Ljava/lang/String;
    move-object v12, v0

    check-cast v12, Ljava/lang/CharSequence;

    invoke-virtual {v5, v12}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v12

    if-eqz v12, :cond_6d

    move-object v12, v0

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v5, v12, v11}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    move/from16 v17, v1

    goto :goto_ba

    .line 278
    :cond_6d
    new-instance v12, Lkotlin/text/Regex;

    sget-object v14, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v12, v7, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v14, v0

    check-cast v14, Ljava/lang/CharSequence;

    move/from16 v17, v1

    const/4 v1, 0x0

    .end local v1  # "ok1":Z
    .local v17, "ok1":Z
    invoke-static {v12, v14, v10, v6, v1}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v12

    .line 279
    .local v12, "mG":Lkotlin/text/MatchResult;
    if-eqz v12, :cond_b9

    invoke-interface {v12}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v1

    invoke-virtual {v0, v10, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v12}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v14

    invoke-virtual {v14}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v14

    invoke-virtual {v0, v14}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v12, v1

    goto :goto_ba

    :cond_b9
    move-object v12, v0

    .line 277
    .end local v12  # "mG":Lkotlin/text/MatchResult;
    :goto_ba
    move-object v0, v12

    .line 281
    const/4 v1, 0x1

    .end local v17  # "ok1":Z
    .restart local v1  # "ok1":Z
    goto :goto_c3

    .line 274
    .end local v5  # "tgtRe":Lkotlin/text/Regex;
    .end local v11  # "safe1":Ljava/lang/String;
    :cond_bd
    move-object/from16 v13, p3

    move-object/from16 v15, p4

    move/from16 v17, v1

    .line 284
    :goto_c3
    const/16 v23, 0x8

    const/16 v24, 0x0

    const/16 v22, 0x0

    move-object/from16 v18, p0

    move-object/from16 v19, p1

    move-object/from16 v20, p5

    move-object/from16 v21, p6

    invoke-static/range {v18 .. v24}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 285
    .local v5, "b2":Ljava/lang/String;
    if-eqz v5, :cond_17a

    .line 286
    new-instance v6, Lkotlin/text/Regex;

    sget-object v11, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v12, p5

    invoke-virtual {v11, v12}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    sget-object v14, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v10, p6

    invoke-virtual {v14, v10}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    move/from16 v18, v2

    .end local v2  # "ok2":Z
    .local v18, "ok2":Z
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v8, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v6, v2, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v2, v6

    .line 287
    .local v2, "tgtRe":Lkotlin/text/Regex;
    invoke-static {v5}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 288
    .local v6, "safe2":Ljava/lang/String;
    move-object v8, v0

    check-cast v8, Ljava/lang/CharSequence;

    invoke-virtual {v2, v8}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_127

    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2, v4, v6}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v16, v2

    const/4 v2, 0x0

    goto :goto_175

    .line 289
    :cond_127
    new-instance v8, Lkotlin/text/Regex;

    sget-object v11, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v8, v7, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    move-object/from16 v16, v2

    const/4 v2, 0x0

    const/4 v11, 0x0

    const/4 v14, 0x2

    .end local v2  # "tgtRe":Lkotlin/text/Regex;
    .local v16, "tgtRe":Lkotlin/text/Regex;
    invoke-static {v8, v7, v2, v14, v11}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 290
    .local v7, "mG":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_174

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {v0, v2, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v11

    invoke-virtual {v0, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_175

    :cond_174
    move-object v4, v0

    .line 288
    .end local v7  # "mG":Lkotlin/text/MatchResult;
    :goto_175
    move-object v0, v4

    .line 292
    const/4 v4, 0x1

    move/from16 v18, v4

    .end local v18  # "ok2":Z
    .local v4, "ok2":Z
    goto :goto_181

    .line 285
    .end local v4  # "ok2":Z
    .end local v6  # "safe2":Ljava/lang/String;
    .end local v16  # "tgtRe":Lkotlin/text/Regex;
    .local v2, "ok2":Z
    :cond_17a
    move-object/from16 v12, p5

    move/from16 v18, v2

    move v2, v10

    move-object/from16 v10, p6

    .line 294
    .end local v2  # "ok2":Z
    .restart local v18  # "ok2":Z
    :goto_181
    new-instance v4, Lkotlin/Triple;

    if-nez v1, :cond_187

    if-eqz v18, :cond_188

    :cond_187
    const/4 v2, 0x1

    :cond_188
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    if-eqz v1, :cond_191

    const-string v6, "[1/2]✔"

    goto :goto_193

    :cond_191
    const-string v6, "[1/2]✗"

    :goto_193
    if-eqz v18, :cond_198

    const-string v7, "[2/2]✔"

    goto :goto_19a

    :cond_198
    const-string v7, "[2/2]✗"

    :goto_19a
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v9, p7

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v11, ": "

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, " "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v0, v2, v6}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v4
.end method

.method private final copyDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 11
    .param p1, "my"  # Ljava/lang/String;
    .param p2, "friend"  # Ljava/lang/String;
    .param p3, "name"  # Ljava/lang/String;

    .line 234
    new-instance v0, Lkotlin/text/Regex;

    sget-object v1, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v1, p3}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "<DataElem\\s+name=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"[^/]*/?>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 235
    .local v0, "re":Lkotlin/text/Regex;
    move-object v1, p2

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    if-nez v1, :cond_31

    return-object p1

    .line 236
    .local v1, "mSrc":Lkotlin/text/MatchResult;
    :cond_31
    move-object v5, p1

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v0, v5, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    if-nez v3, :cond_3b

    return-object p1

    .line 237
    .local v3, "mMy":Lkotlin/text/MatchResult;
    :cond_3b
    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    const-string v4, "substring(...)"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v6

    add-int/lit8 v6, v6, 0x1

    invoke-virtual {p1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private final copyVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 16
    .param p1, "my"  # Ljava/lang/String;
    .param p2, "friend"  # Ljava/lang/String;
    .param p3, "name"  # Ljava/lang/String;

    .line 219
    new-instance v0, Lkotlin/text/Regex;

    sget-object v1, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v1, p3}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "<Var\\s+name=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"([^/]*/?>)"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 220
    .local v0, "srcRe":Lkotlin/text/Regex;
    move-object v1, p2

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-static {v0, v1, v2, v4, v5}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    if-nez v1, :cond_31

    return-object p1

    .line 221
    .local v1, "mSrc":Lkotlin/text/MatchResult;
    :cond_31
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v6

    const/4 v7, 0x1

    invoke-interface {v6, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "<Var name=\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 222
    .local v6, "newTag":Ljava/lang/String;
    invoke-static {v6}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 223
    .local v8, "safeTag":Ljava/lang/String;
    new-instance v9, Lkotlin/text/Regex;

    sget-object v10, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v10, p3}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v10, "\"[^/]*/?>"

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v9, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v3, v9

    .line 224
    .local v3, "myRe":Lkotlin/text/Regex;
    move-object v9, p1

    check-cast v9, Ljava/lang/CharSequence;

    invoke-virtual {v3, v9}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_92

    .line 225
    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3, v2, v8}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_d0

    .line 227
    :cond_92
    move-object v9, p1

    check-cast v9, Ljava/lang/CharSequence;

    const-string v10, "</Vars>"

    move-object v11, v10

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v9, v11, v2, v4, v5}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_c0

    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v4, Lkotlin/text/Regex;

    invoke-direct {v4, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, "\n    </Vars>"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v2, v5}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_d0

    .line 228
    :cond_c0
    sget-object v2, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v2, p1, p3, v4}, Lcom/twntool/editor/core/XmlProcessor;->insertVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 224
    :goto_d0
    return-object v2
.end method

.method private final extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;
    .registers 18
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "openPrefix"  # Ljava/lang/String;
    .param p3, "closeTag"  # Ljava/lang/String;
    .param p4, "fromPos"  # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "I)",
            "Lkotlin/Triple<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 259
    move-object v0, p1

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object v2, p2

    move/from16 v3, p4

    invoke-static/range {v1 .. v6}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v1

    .line 260
    .local v1, "start":I
    const/4 v2, 0x0

    const/4 v3, -0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    if-ne v1, v3, :cond_1c

    new-instance v3, Lkotlin/Triple;

    invoke-direct {v3, v2, v4, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .line 261
    :cond_1c
    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v11, 0x4

    const/4 v12, 0x0

    const/4 v10, 0x0

    move-object/from16 v8, p3

    move v9, v1

    invoke-static/range {v7 .. v12}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v5

    .line 262
    .local v5, "endTag":I
    if-ne v5, v3, :cond_31

    new-instance v3, Lkotlin/Triple;

    invoke-direct {v3, v2, v4, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .line 263
    :cond_31
    new-instance v2, Lkotlin/Triple;

    invoke-virtual/range {p3 .. p3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v3, v5

    invoke-virtual {p1, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "substring(...)"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual/range {p3 .. p3}, Ljava/lang/String;->length()I

    move-result v6

    add-int/2addr v6, v5

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-direct {v2, v3, v4, v6}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v2
.end method

.method static synthetic extractBlock$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;
    .registers 7

    .line 257
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_5

    const/4 p4, 0x0

    :cond_5
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/twntool/editor/core/DesbanEngine;->extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;

    move-result-object p0

    return-object p0
.end method

.method private final processUnlockAchievements(Ljava/lang/String;)Lkotlin/Triple;
    .registers 33
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

    .line 383
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "AchReward_([A-Za-z0-9_]+)"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object/from16 v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v0

    new-instance v1, Lcom/twntool/editor/core/DesbanEngine$$ExternalSyntheticLambda2;

    invoke-direct {v1}, Lcom/twntool/editor/core/DesbanEngine$$ExternalSyntheticLambda2;-><init>()V

    .line 384
    invoke-static {v0, v1}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v0

    invoke-static {v0}, Lkotlin/sequences/SequencesKt;->toSet(Lkotlin/sequences/Sequence;)Ljava/util/Set;

    move-result-object v0

    .line 383
    nop

    .line 385
    .local v0, "presentes":Ljava/util/Set;
    sget-object v1, Lcom/twntool/editor/core/DesbanEngine;->ACHIEVEMENT_REWARDS:Ljava/util/List;

    check-cast v1, Ljava/lang/Iterable;

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->toSet(Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v1

    move-object v5, v0

    check-cast v5, Ljava/lang/Iterable;

    invoke-static {v1, v5}, Lkotlin/collections/SetsKt;->plus(Ljava/util/Set;Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v1

    .line 387
    .local v1, "todos":Ljava/util/Set;
    move-object/from16 v5, p1

    .line 388
    .local v5, "out":Ljava/lang/String;
    const/4 v6, 0x0

    .line 389
    .local v6, "atualizados":I
    const/4 v7, 0x0

    .line 390
    .local v7, "criados":I
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_37
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_223

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 391
    .local v9, "nome":Ljava/lang/String;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "AchReward_"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 392
    .local v10, "varName":Ljava/lang/String;
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "<Var name=\""

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "\" v=\"4\" t=\"i\"/>"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 393
    .local v11, "newTag":Ljava/lang/String;
    invoke-static {v11}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 394
    .local v12, "safe":Ljava/lang/String;
    new-instance v13, Lkotlin/text/Regex;

    sget-object v14, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v14, v10}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "<Var\\s+name=\""

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "\"[^/]*/>"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v13, v14, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 395
    .local v13, "pattern":Lkotlin/text/Regex;
    move-object v14, v5

    check-cast v14, Ljava/lang/CharSequence;

    invoke-virtual {v13, v14}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v14

    if-eqz v14, :cond_b6

    .line 396
    move-object v14, v5

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v13, v14, v12}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 397
    add-int/lit8 v6, v6, 0x1

    move-object/from16 v18, v0

    move-object/from16 v19, v1

    move-object/from16 v21, v8

    goto/16 :goto_162

    .line 399
    :cond_b6
    new-instance v14, Lkotlin/text/Regex;

    const-string v15, "</Global\\s*>"

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v14, v15, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v3, v5

    check-cast v3, Ljava/lang/CharSequence;

    move-object/from16 v18, v0

    const/4 v0, 0x2

    const/4 v15, 0x0

    .end local v0  # "presentes":Ljava/util/Set;
    .local v18, "presentes":Ljava/util/Set;
    invoke-static {v14, v3, v15, v0, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 400
    .local v3, "mG":Lkotlin/text/MatchResult;
    const-string v0, "\n"

    const-string v14, "substring(...)"

    if-eqz v3, :cond_10e

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {v5, v15, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v15

    invoke-virtual {v5, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v19, v1

    move-object/from16 v20, v3

    move-object/from16 v21, v8

    goto :goto_160

    .line 402
    :cond_10e
    new-instance v4, Lkotlin/text/Regex;

    const-string v15, "</root\\s*>"

    move-object/from16 v19, v1

    .end local v1  # "todos":Ljava/util/Set;
    .local v19, "todos":Ljava/util/Set;
    sget-object v1, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v4, v15, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v1, v5

    check-cast v1, Ljava/lang/CharSequence;

    move-object/from16 v20, v3

    move-object/from16 v21, v8

    const/4 v3, 0x2

    const/4 v8, 0x0

    const/4 v15, 0x0

    .end local v3  # "mG":Lkotlin/text/MatchResult;
    .local v20, "mG":Lkotlin/text/MatchResult;
    invoke-static {v4, v1, v15, v3, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 403
    .local v1, "mR":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_160

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    invoke-virtual {v5, v15, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {v5, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 405
    .end local v1  # "mR":Lkotlin/text/MatchResult;
    :cond_160
    :goto_160
    add-int/lit8 v7, v7, 0x1

    .line 408
    .end local v20  # "mG":Lkotlin/text/MatchResult;
    :goto_162
    sget-object v0, Lcom/twntool/editor/core/DesbanEngine;->ACHIEVEMENT_COUNTER_MAP:Ljava/util/Map;

    invoke-interface {v0, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    if-nez v0, :cond_177

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    move-object/from16 v8, v21

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    goto/16 :goto_37

    .line 409
    .local v0, "counters":Ljava/util/List;
    :cond_177
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_17b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_214

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lkotlin/Pair;

    invoke-virtual {v3}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .local v4, "counterName":Ljava/lang/String;
    invoke-virtual {v3}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Number;

    invoke-virtual {v3}, Ljava/lang/Number;->longValue()J

    move-result-wide v14

    .line 410
    .local v14, "minValue":J
    new-instance v3, Lkotlin/text/Regex;

    sget-object v8, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v8, v4}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    move-object/from16 v20, v0

    .end local v0  # "counters":Ljava/util/List;
    .local v20, "counters":Ljava/util/List;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v8, "\"\\s+v=\"(\\d+)\""

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 411
    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    .line 410
    invoke-direct {v3, v0, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 411
    move-object v0, v5

    check-cast v0, Ljava/lang/CharSequence;

    move-object/from16 v16, v1

    move-object/from16 v17, v2

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v8, 0x0

    invoke-static {v3, v0, v8, v1, v2}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 410
    nop

    .line 412
    .local v0, "mCur":Lkotlin/text/MatchResult;
    if-eqz v0, :cond_1e8

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_1e8

    const/4 v1, 0x1

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    if-eqz v1, :cond_1e8

    invoke-static {v1}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v1

    if-eqz v1, :cond_1e8

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v22

    goto :goto_1ea

    :cond_1e8
    const-wide/16 v22, 0x0

    :goto_1ea
    move-wide/from16 v29, v22

    .line 413
    .local v29, "curVal":J
    cmp-long v1, v29, v14

    if-gez v1, :cond_20c

    .line 414
    invoke-static {v14, v15}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v25

    const/16 v27, 0x8

    const/16 v28, 0x0

    const/16 v26, 0x0

    move-object/from16 v22, p0

    move-object/from16 v23, v5

    move-object/from16 v24, v4

    invoke-static/range {v22 .. v28}, Lcom/twntool/editor/core/DesbanEngine;->upsertVar$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v1, v16

    move-object/from16 v2, v17

    move-object/from16 v0, v20

    .end local v0  # "mCur":Lkotlin/text/MatchResult;
    .end local v4  # "counterName":Ljava/lang/String;
    .end local v14  # "minValue":J
    .end local v29  # "curVal":J
    goto/16 :goto_17b

    .line 413
    .restart local v0  # "mCur":Lkotlin/text/MatchResult;
    .restart local v4  # "counterName":Ljava/lang/String;
    .restart local v14  # "minValue":J
    .restart local v29  # "curVal":J
    :cond_20c
    move-object/from16 v1, v16

    move-object/from16 v2, v17

    move-object/from16 v0, v20

    goto/16 :goto_17b

    .line 409
    .end local v4  # "counterName":Ljava/lang/String;
    .end local v14  # "minValue":J
    .end local v20  # "counters":Ljava/util/List;
    .end local v29  # "curVal":J
    .local v0, "counters":Ljava/util/List;
    :cond_214
    move-object/from16 v20, v0

    const/4 v2, 0x0

    const/4 v8, 0x0

    .end local v0  # "counters":Ljava/util/List;
    .restart local v20  # "counters":Ljava/util/List;
    move-object v4, v2

    move v2, v8

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    move-object/from16 v8, v21

    const/4 v3, 0x2

    goto/16 :goto_37

    .line 418
    .end local v9  # "nome":Ljava/lang/String;
    .end local v10  # "varName":Ljava/lang/String;
    .end local v11  # "newTag":Ljava/lang/String;
    .end local v12  # "safe":Ljava/lang/String;
    .end local v13  # "pattern":Lkotlin/text/Regex;
    .end local v18  # "presentes":Ljava/util/Set;
    .end local v19  # "todos":Ljava/util/Set;
    .end local v20  # "counters":Ljava/util/List;
    .local v0, "presentes":Ljava/util/Set;
    .local v1, "todos":Ljava/util/Set;
    :cond_223
    move-object/from16 v18, v0

    move-object/from16 v19, v1

    .end local v0  # "presentes":Ljava/util/Set;
    .end local v1  # "todos":Ljava/util/Set;
    .restart local v18  # "presentes":Ljava/util/Set;
    .restart local v19  # "todos":Ljava/util/Set;
    new-instance v0, Lkotlin/Triple;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-direct {v0, v5, v1, v2}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static final processUnlockAchievements$lambda$1(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 3
    .param p0, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 384
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private final replaceBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 14
    .param p1, "my"  # Ljava/lang/String;
    .param p2, "friend"  # Ljava/lang/String;
    .param p3, "tagName"  # Ljava/lang/String;

    .line 242
    new-instance v0, Lkotlin/text/Regex;

    .line 243
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "<"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "[^>]*>.*?</"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ">|<"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "[^/]*/>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 244
    sget-object v2, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    .line 242
    invoke-direct {v0, v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 246
    .local v0, "blockRe":Lkotlin/text/Regex;
    move-object v1, p2

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    if-nez v1, :cond_41

    return-object p1

    .line 247
    .local v1, "mSrc":Lkotlin/text/MatchResult;
    :cond_41
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v5

    .line 248
    .local v5, "srcBlock":Ljava/lang/String;
    invoke-static {v5}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 249
    .local v6, "safeBlock":Ljava/lang/String;
    move-object v7, p1

    check-cast v7, Ljava/lang/CharSequence;

    invoke-virtual {v0, v7}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_5d

    move-object v2, p1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, v2, v6}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_ac

    .line 251
    :cond_5d
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "</Global\\s*>"

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v7, v8, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v7, v8, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v3

    .line 252
    .local v3, "mG":Lkotlin/text/MatchResult;
    if-eqz v3, :cond_ab

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {p1, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    const-string v4, "substring(...)"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {p1, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\n"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_ac

    :cond_ab
    move-object v2, p1

    .line 249
    .end local v3  # "mG":Lkotlin/text/MatchResult;
    :goto_ac
    return-object v2
.end method

.method private final varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .registers 6
    .param p1, "key"  # Ljava/lang/String;
    .param p2, "args"  # [Ljava/lang/Object;

    .line 36
    sget-object v0, Lcom/twntool/editor/data/Strings;->INSTANCE:Lcom/twntool/editor/data/Strings;

    sget-object v1, Lcom/twntool/editor/data/AppState;->INSTANCE:Lcom/twntool/editor/data/AppState;

    invoke-virtual {v1}, Lcom/twntool/editor/data/AppState;->getLang()Ljava/lang/String;

    move-result-object v1

    array-length v2, p2

    invoke-static {p2, v2}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lcom/twntool/editor/data/Strings;->t(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private final upsertVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 21
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "name"  # Ljava/lang/String;
    .param p3, "value"  # Ljava/lang/String;
    .param p4, "tipo"  # Ljava/lang/String;

    .line 206
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

    .line 207
    .local v2, "newTag":Ljava/lang/String;
    invoke-static {v2}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 208
    .local v5, "safeTag":Ljava/lang/String;
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

    .line 209
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

    .line 211
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

    .line 212
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

    .line 213
    :cond_c4
    new-instance v13, Lkotlin/text/Regex;

    const-string v14, "</root\\s*>"

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v13, v14, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v14, v0

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v13, v14, v9, v10, v11}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v10

    .line 214
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

.method static synthetic upsertVar$default(Lcom/twntool/editor/core/DesbanEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;
    .registers 7

    .line 205
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_6

    const-string p4, "i"

    :cond_6
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/twntool/editor/core/DesbanEngine;->upsertVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final applyDesban(Ljava/lang/String;Ljava/lang/String;)Lcom/twntool/editor/core/DesbanEngine$DesbanResult;
    .registers 4
    .param p1, "myXml"  # Ljava/lang/String;
    .param p2, "friendXml"  # Ljava/lang/String;

    const-string v0, "myXml"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "friendXml"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1047
    invoke-virtual {p0, p1, p2}, Lcom/twntool/editor/core/DesbanEngine;->applyEtapa1(Ljava/lang/String;Ljava/lang/String;)Lcom/twntool/editor/core/DesbanEngine$DesbanResult;

    move-result-object v0

    return-object v0
.end method

.method public final applyEtapa1(Ljava/lang/String;Ljava/lang/String;)Lcom/twntool/editor/core/DesbanEngine$DesbanResult;
    .registers 43
    .param p1, "myXml"  # Ljava/lang/String;
    .param p2, "friendXml"  # Ljava/lang/String;

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    const-string v2, "myXml"

    move-object/from16 v3, p1

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v2, "friendXml"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 575
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/List;

    .line 576
    .local v2, "log":Ljava/util/List;
    move-object/from16 v4, p1

    .line 578
    .local v4, "result":Ljava/lang/String;
    const/4 v5, 0x0

    new-array v6, v5, [Ljava/lang/Object;

    const-string v7, "desban_step_progress"

    invoke-direct {v0, v7, v6}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "i:"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v2, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 579
    const/4 v6, 0x0

    .line 580
    .local v6, "copiedVars":I
    sget-object v7, Lcom/twntool/editor/core/DesbanEngine;->PROGRESS_VARS:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_3f
    :goto_3f
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_59

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 581
    .local v9, "v":Ljava/lang/String;
    move-object v10, v4

    .line 582
    .local v10, "before":Ljava/lang/String;
    invoke-direct {v0, v4, v1, v9}, Lcom/twntool/editor/core/DesbanEngine;->copyVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 583
    invoke-static {v4, v10}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_3f

    .end local v9  # "v":Ljava/lang/String;
    .end local v10  # "before":Ljava/lang/String;
    add-int/lit8 v6, v6, 0x1

    goto :goto_3f

    .line 585
    :cond_59
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    const-string v9, "desban_log_progress_done"

    invoke-direct {v0, v9, v7}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "s:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 590
    sget-object v7, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    const-string v9, "levelup"

    invoke-virtual {v7, v1, v9}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 591
    .local v7, "lvStr":Ljava/lang/String;
    sget-object v11, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    const-string v12, "experience"

    invoke-virtual {v11, v1, v12}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 592
    .local v11, "xpStr":Ljava/lang/String;
    const/4 v14, 0x1

    if-eqz v7, :cond_10a

    if-eqz v11, :cond_10a

    .line 593
    invoke-static {v11}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v15

    if-eqz v15, :cond_9d

    invoke-virtual {v15}, Ljava/lang/Long;->longValue()J

    move-result-wide v15

    goto :goto_9f

    :cond_9d
    const-wide/16 v15, 0x0

    .line 594
    .local v15, "xp":J
    :goto_9f
    const-wide/32 v17, 0x1e5d6a06

    xor-long v17, v15, v17

    .line 595
    .local v17, "sexpx":J
    const/4 v13, 0x3

    new-array v13, v13, [Lkotlin/Pair;

    invoke-static {v9, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    aput-object v9, v13, v5

    .line 596
    invoke-static/range {v15 .. v16}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v9

    invoke-static {v12, v9}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    aput-object v9, v13, v14

    .line 595
    nop

    .line 597
    const-string v9, "sexpx"

    invoke-static/range {v17 .. v18}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v12

    invoke-static {v9, v12}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    const/4 v12, 0x2

    aput-object v9, v13, v12

    .line 595
    invoke-static {v13}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_cd
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_10a

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lkotlin/Pair;

    invoke-virtual {v12}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    .local v13, "name":Ljava/lang/String;
    invoke-virtual {v12}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .line 598
    .local v12, "value":Ljava/lang/String;
    sget-object v14, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v14, v4, v13, v12}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v14

    invoke-virtual {v14}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Ljava/lang/String;

    .local v21, "out":Ljava/lang/String;
    invoke-virtual {v14}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/Boolean;

    invoke-virtual {v14}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v14

    .line 599
    .local v14, "ok":Z
    if-eqz v14, :cond_100

    move-object/from16 v5, v21

    goto :goto_106

    :cond_100
    sget-object v5, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v5, v4, v13, v12}, Lcom/twntool/editor/core/XmlProcessor;->insertVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    :goto_106
    move-object v4, v5

    const/4 v5, 0x0

    const/4 v14, 0x1

    .end local v12  # "value":Ljava/lang/String;
    .end local v13  # "name":Ljava/lang/String;
    .end local v14  # "ok":Z
    .end local v21  # "out":Ljava/lang/String;
    goto :goto_cd

    .line 603
    .end local v15  # "xp":J
    .end local v17  # "sexpx":J
    :cond_10a
    const-string v5, "desban_step_stats"

    const/4 v9, 0x0

    new-array v12, v9, [Ljava/lang/Object;

    invoke-direct {v0, v5, v12}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 604
    sget-object v5, Lcom/twntool/editor/data/FieldMap;->INSTANCE:Lcom/twntool/editor/data/FieldMap;

    invoke-virtual {v5}, Lcom/twntool/editor/data/FieldMap;->getKeys()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_131
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_1b1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 605
    .local v9, "key":Ljava/lang/String;
    sget-object v12, Lcom/twntool/editor/data/FieldMap;->INSTANCE:Lcom/twntool/editor/data/FieldMap;

    invoke-virtual {v12}, Lcom/twntool/editor/data/FieldMap;->getMap()Ljava/util/Map;

    move-result-object v12

    invoke-interface {v12, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    invoke-static {v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    check-cast v12, Lcom/twntool/editor/data/FieldDef;

    .line 606
    .local v12, "fieldDef":Lcom/twntool/editor/data/FieldDef;
    const/4 v13, 0x0

    .line 607
    .local v13, "srcVal":Ljava/lang/String;
    invoke-virtual {v12}, Lcom/twntool/editor/data/FieldDef;->getXmlKeys()Ljava/util/List;

    move-result-object v14

    invoke-interface {v14}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_155
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-eqz v15, :cond_16e

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 608
    .local v15, "xmlKey":Ljava/lang/String;
    sget-object v3, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v3, v1, v15}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 609
    .local v3, "v":Ljava/lang/String;
    if-eqz v3, :cond_16b

    move-object v13, v3

    goto :goto_16e

    :cond_16b
    move-object/from16 v3, p1

    .end local v3  # "v":Ljava/lang/String;
    .end local v15  # "xmlKey":Ljava/lang/String;
    goto :goto_155

    .line 611
    :cond_16e
    :goto_16e
    if-eqz v13, :cond_1ae

    .line 612
    invoke-virtual {v12}, Lcom/twntool/editor/data/FieldDef;->getXmlKeys()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_178
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_1ab

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .line 613
    .local v14, "xmlKey":Ljava/lang/String;
    sget-object v15, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v15, v4, v14, v13}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Ljava/lang/String;

    .local v16, "out":Ljava/lang/String;
    invoke-virtual {v15}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/Boolean;

    invoke-virtual {v15}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v15

    .line 614
    .local v15, "ok":Z
    move-object/from16 v17, v3

    if-eqz v15, :cond_1a1

    move-object/from16 v3, v16

    goto :goto_1a7

    :cond_1a1
    sget-object v3, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v3, v4, v14, v13}, Lcom/twntool/editor/core/XmlProcessor;->insertVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_1a7
    move-object v4, v3

    move-object/from16 v3, v17

    .end local v14  # "xmlKey":Ljava/lang/String;
    .end local v15  # "ok":Z
    .end local v16  # "out":Ljava/lang/String;
    goto :goto_178

    .line 612
    :cond_1ab
    move-object/from16 v3, p1

    goto :goto_131

    .line 611
    :cond_1ae
    move-object/from16 v3, p1

    goto :goto_131

    .line 617
    .end local v9  # "key":Ljava/lang/String;
    .end local v12  # "fieldDef":Lcom/twntool/editor/data/FieldDef;
    .end local v13  # "srcVal":Ljava/lang/String;
    :cond_1b1
    const-string v3, "desban_log_stats_done"

    const/4 v5, 0x0

    new-array v9, v5, [Ljava/lang/Object;

    invoke-direct {v0, v3, v9}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 619
    const-string v3, "desban_step_quests"

    new-array v9, v5, [Ljava/lang/Object;

    invoke-direct {v0, v3, v9}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 620
    const-string v3, "Common_prevQuestId"

    invoke-direct {v0, v4, v1, v3}, Lcom/twntool/editor/core/DesbanEngine;->copyDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 621
    .end local v4  # "result":Ljava/lang/String;
    .local v3, "result":Ljava/lang/String;
    const-string v4, "lastContiniouslyCompletedQuest"

    invoke-direct {v0, v3, v1, v4}, Lcom/twntool/editor/core/DesbanEngine;->copyDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 623
    const/4 v4, 0x0

    .line 624
    .local v4, "qbCount":I
    new-instance v5, Lkotlin/text/Regex;

    const-string v9, "<DataElem\\s+name=\"(QB_\\d+_\\d+)\"\\s+type=\"int\"\\s+value=\"4\"\\s*/>"

    invoke-direct {v5, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 625
    .local v5, "qbRe":Lkotlin/text/Regex;
    move-object v9, v1

    check-cast v9, Ljava/lang/CharSequence;

    const/4 v12, 0x0

    const/4 v13, 0x2

    const/4 v14, 0x0

    invoke-static {v5, v9, v14, v13, v12}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v9

    invoke-interface {v9}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_20c
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_2b1

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    move-object/from16 v21, v13

    check-cast v21, Lkotlin/text/MatchResult;

    .line 626
    .local v21, "m":Lkotlin/text/MatchResult;
    invoke-interface/range {v21 .. v21}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v13

    const/4 v14, 0x1

    invoke-interface {v13, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    move-object v15, v13

    check-cast v15, Ljava/lang/String;

    .line 627
    .local v15, "qbName":Ljava/lang/String;
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "<DataElem name=\""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\" type=\"int\" value=\"4\"/>"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v23

    .line 628
    .local v23, "newTag":Ljava/lang/String;
    new-instance v13, Lkotlin/text/Regex;

    sget-object v14, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v14, v15}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v24, v5

    .end local v5  # "qbRe":Lkotlin/text/Regex;
    .local v24, "qbRe":Lkotlin/text/Regex;
    const-string v5, "<DataElem\\s+name=\""

    invoke-virtual {v12, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v12, "\"[^/]*/?>"

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v13, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v5, v13

    .line 629
    .local v5, "myQbRe":Lkotlin/text/Regex;
    invoke-static/range {v23 .. v23}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 630
    .local v12, "safeTag":Ljava/lang/String;
    move-object v13, v3

    check-cast v13, Ljava/lang/CharSequence;

    invoke-virtual {v5, v13}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_280

    .line 631
    move-object v13, v3

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v5, v13, v12}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    move-object/from16 v26, v15

    goto :goto_2a8

    .line 633
    :cond_280
    nop

    .line 634
    nop

    .line 635
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n    <DataElem name=\"Common_prevQuestId\""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    .line 633
    const/16 v17, 0x4

    const/16 v18, 0x0

    const-string v14, "<DataElem name=\"Common_prevQuestId\""

    const/16 v25, 0x0

    move-object v13, v3

    move-object/from16 v26, v15

    .end local v15  # "qbName":Ljava/lang/String;
    .local v26, "qbName":Ljava/lang/String;
    move-object/from16 v15, v16

    move/from16 v16, v25

    invoke-static/range {v13 .. v18}, Lkotlin/text/StringsKt;->replaceFirst$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    .line 630
    :goto_2a8
    move-object v3, v13

    .line 638
    nop

    .end local v5  # "myQbRe":Lkotlin/text/Regex;
    .end local v12  # "safeTag":Ljava/lang/String;
    .end local v21  # "m":Lkotlin/text/MatchResult;
    .end local v23  # "newTag":Ljava/lang/String;
    .end local v26  # "qbName":Ljava/lang/String;
    add-int/lit8 v4, v4, 0x1

    move-object/from16 v5, v24

    const/4 v12, 0x0

    goto/16 :goto_20c

    .line 640
    .end local v24  # "qbRe":Lkotlin/text/Regex;
    .local v5, "qbRe":Lkotlin/text/Regex;
    :cond_2b1
    move-object/from16 v24, v5

    .end local v5  # "qbRe":Lkotlin/text/Regex;
    .restart local v24  # "qbRe":Lkotlin/text/Regex;
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    const-string v9, "desban_log_quests_done"

    invoke-direct {v0, v9, v5}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 642
    const-string v5, "HarvestForTime"

    invoke-direct {v0, v3, v1, v5}, Lcom/twntool/editor/core/DesbanEngine;->replaceBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 643
    const-string v5, "SeasonTicketCenter"

    invoke-direct {v0, v3, v1, v5}, Lcom/twntool/editor/core/DesbanEngine;->replaceBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 644
    const-string v5, "desban_log_events_done"

    const/4 v9, 0x0

    new-array v12, v9, [Ljava/lang/Object;

    invoke-direct {v0, v5, v12}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 646
    new-instance v5, Lkotlin/text/Regex;

    const-string v9, "<v\\s+n=\"(CHT_[^\"]+)\""

    invoke-direct {v5, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 647
    .local v5, "chtRe":Lkotlin/text/Regex;
    move-object v9, v1

    check-cast v9, Ljava/lang/CharSequence;

    const/4 v12, 0x0

    const/4 v13, 0x2

    const/4 v14, 0x0

    invoke-static {v5, v9, v14, v13, v12}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v9

    new-instance v15, Lcom/twntool/editor/core/DesbanEngine$$ExternalSyntheticLambda0;

    invoke-direct {v15}, Lcom/twntool/editor/core/DesbanEngine$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v9, v15}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v9

    invoke-static {v9}, Lkotlin/sequences/SequencesKt;->toSet(Lkotlin/sequences/Sequence;)Ljava/util/Set;

    move-result-object v9

    .line 648
    .local v9, "chtSrc":Ljava/util/Set;
    move-object v15, v3

    check-cast v15, Ljava/lang/CharSequence;

    invoke-static {v5, v15, v14, v13, v12}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v15

    new-instance v12, Lcom/twntool/editor/core/DesbanEngine$$ExternalSyntheticLambda1;

    invoke-direct {v12}, Lcom/twntool/editor/core/DesbanEngine$$ExternalSyntheticLambda1;-><init>()V

    invoke-static {v15, v12}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v12

    invoke-static {v12}, Lkotlin/sequences/SequencesKt;->toSet(Lkotlin/sequences/Sequence;)Ljava/util/Set;

    move-result-object v12

    .line 649
    .local v12, "chtMine":Ljava/util/Set;
    const/4 v13, 0x0

    .line 650
    .local v13, "chtAdded":I
    move-object v14, v12

    check-cast v14, Ljava/lang/Iterable;

    invoke-static {v9, v14}, Lkotlin/collections/SetsKt;->minus(Ljava/util/Set;Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v14

    check-cast v14, Ljava/lang/Iterable;

    invoke-static {v14}, Lkotlin/collections/CollectionsKt;->sorted(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v14

    invoke-interface {v14}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_342
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-eqz v15, :cond_3f6

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 651
    .local v15, "cht":Ljava/lang/String;
    move-object/from16 v16, v12

    check-cast v16, Ljava/util/Collection;

    invoke-interface/range {v16 .. v16}, Ljava/util/Collection;->isEmpty()Z

    move-result v16

    const/16 v17, 0x1

    xor-int/lit8 v16, v16, 0x1

    move/from16 v17, v4

    .end local v4  # "qbCount":I
    .local v17, "qbCount":I
    const-string v4, "<v n=\""

    if-eqz v16, :cond_388

    move-object/from16 v16, v12

    check-cast v16, Ljava/lang/Iterable;

    invoke-static/range {v16 .. v16}, Lkotlin/collections/CollectionsKt;->sorted(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v16

    move-object/from16 v18, v5

    .end local v5  # "chtRe":Lkotlin/text/Regex;
    .local v18, "chtRe":Lkotlin/text/Regex;
    invoke-static/range {v16 .. v16}, Lkotlin/collections/CollectionsKt;->first(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v5

    move/from16 v16, v6

    .end local v6  # "copiedVars":I
    .local v16, "copiedVars":I
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\""

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_38e

    .end local v16  # "copiedVars":I
    .end local v18  # "chtRe":Lkotlin/text/Regex;
    .restart local v5  # "chtRe":Lkotlin/text/Regex;
    .restart local v6  # "copiedVars":I
    :cond_388
    move-object/from16 v18, v5

    move/from16 v16, v6

    .end local v5  # "chtRe":Lkotlin/text/Regex;
    .end local v6  # "copiedVars":I
    .restart local v16  # "copiedVars":I
    .restart local v18  # "chtRe":Lkotlin/text/Regex;
    const-string v5, "</SeenTips>"

    .line 652
    .local v5, "anchor":Ljava/lang/String;
    :goto_38e
    move-object v6, v12

    check-cast v6, Ljava/util/Collection;

    invoke-interface {v6}, Ljava/util/Collection;->isEmpty()Z

    move-result v6

    const/16 v20, 0x1

    xor-int/lit8 v6, v6, 0x1

    if-eqz v6, :cond_3b3

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, "\"/>\n    "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    goto :goto_3c6

    :cond_3b3
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, "\"/>\n</SeenTips>"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    :goto_3c6
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 653
    .local v4, "replacement":Ljava/lang/String;
    invoke-static {v4}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 654
    .local v6, "safeRepl":Ljava/lang/String;
    move-object/from16 v21, v4

    .end local v4  # "replacement":Ljava/lang/String;
    .local v21, "replacement":Ljava/lang/String;
    move-object v4, v3

    check-cast v4, Ljava/lang/CharSequence;

    move-object/from16 v23, v3

    .end local v3  # "result":Ljava/lang/String;
    .local v23, "result":Ljava/lang/String;
    new-instance v3, Lkotlin/text/Regex;

    move-object/from16 v25, v7

    .end local v7  # "lvStr":Ljava/lang/String;
    .local v25, "lvStr":Ljava/lang/String;
    sget-object v7, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v7, v5}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v3, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3, v4, v6}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 655
    .end local v23  # "result":Ljava/lang/String;
    .restart local v3  # "result":Ljava/lang/String;
    nop

    .end local v5  # "anchor":Ljava/lang/String;
    .end local v6  # "safeRepl":Ljava/lang/String;
    .end local v15  # "cht":Ljava/lang/String;
    .end local v21  # "replacement":Ljava/lang/String;
    add-int/lit8 v13, v13, 0x1

    move/from16 v6, v16

    move/from16 v4, v17

    move-object/from16 v5, v18

    move-object/from16 v7, v25

    goto/16 :goto_342

    .line 657
    .end local v16  # "copiedVars":I
    .end local v17  # "qbCount":I
    .end local v18  # "chtRe":Lkotlin/text/Regex;
    .end local v25  # "lvStr":Ljava/lang/String;
    .local v4, "qbCount":I
    .local v5, "chtRe":Lkotlin/text/Regex;
    .local v6, "copiedVars":I
    .restart local v7  # "lvStr":Ljava/lang/String;
    :cond_3f6
    move-object/from16 v23, v3

    move/from16 v17, v4

    move-object/from16 v18, v5

    move/from16 v16, v6

    move-object/from16 v25, v7

    .end local v3  # "result":Ljava/lang/String;
    .end local v4  # "qbCount":I
    .end local v5  # "chtRe":Lkotlin/text/Regex;
    .end local v6  # "copiedVars":I
    .end local v7  # "lvStr":Ljava/lang/String;
    .restart local v16  # "copiedVars":I
    .restart local v17  # "qbCount":I
    .restart local v18  # "chtRe":Lkotlin/text/Regex;
    .restart local v23  # "result":Ljava/lang/String;
    .restart local v25  # "lvStr":Ljava/lang/String;
    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "desban_log_hints_done"

    invoke-direct {v0, v4, v3}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 659
    new-instance v3, Lkotlin/text/Regex;

    const-string v4, "<Var\\s+name=\"([^\"]+_state)\"[^/]*/>"

    invoke-direct {v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 660
    .local v3, "stateRe":Lkotlin/text/Regex;
    const/4 v4, 0x0

    .line 661
    .local v4, "stateCount":I
    move-object v5, v1

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v14, 0x0

    invoke-static {v3, v5, v14, v7, v6}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v5

    invoke-interface {v5}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v5

    move v6, v4

    move-object/from16 v4, v23

    .end local v23  # "result":Ljava/lang/String;
    .local v4, "result":Ljava/lang/String;
    .local v6, "stateCount":I
    :goto_43b
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_467

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lkotlin/text/MatchResult;

    .line 662
    .local v7, "m":Lkotlin/text/MatchResult;
    move-object v14, v4

    .line 663
    .local v14, "before":Ljava/lang/String;
    invoke-interface {v7}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v15

    move-object/from16 v21, v3

    const/4 v3, 0x1

    .end local v3  # "stateRe":Lkotlin/text/Regex;
    .local v21, "stateRe":Lkotlin/text/Regex;
    invoke-interface {v15, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    invoke-direct {v0, v4, v1, v15}, Lcom/twntool/editor/core/DesbanEngine;->copyVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 664
    invoke-static {v4, v14}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_464

    .end local v7  # "m":Lkotlin/text/MatchResult;
    .end local v14  # "before":Ljava/lang/String;
    add-int/lit8 v6, v6, 0x1

    move-object/from16 v3, v21

    goto :goto_43b

    .restart local v7  # "m":Lkotlin/text/MatchResult;
    .restart local v14  # "before":Ljava/lang/String;
    :cond_464
    move-object/from16 v3, v21

    goto :goto_43b

    .line 666
    .end local v7  # "m":Lkotlin/text/MatchResult;
    .end local v14  # "before":Ljava/lang/String;
    .end local v21  # "stateRe":Lkotlin/text/Regex;
    .restart local v3  # "stateRe":Lkotlin/text/Regex;
    :cond_467
    move-object/from16 v21, v3

    .end local v3  # "stateRe":Lkotlin/text/Regex;
    .restart local v21  # "stateRe":Lkotlin/text/Regex;
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v5, "desban_log_tutorial_done"

    invoke-direct {v0, v5, v3}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 668
    const-string v3, "desban_step_decor"

    const/4 v5, 0x0

    new-array v7, v5, [Ljava/lang/Object;

    invoke-direct {v0, v3, v7}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 674
    new-instance v3, Lcom/twntool/editor/core/CloneEngine$CloneOptions;

    .line 675
    nop

    .line 674
    nop

    .line 675
    nop

    .line 676
    nop

    .line 677
    nop

    .line 674
    const/16 v38, 0x2

    const/16 v39, 0x0

    const/16 v27, 0x0

    const/16 v28, 0x0

    const/16 v29, 0x0

    const/16 v30, 0x1

    const/16 v31, 0x1

    const/16 v32, 0x1

    const/16 v33, 0x1

    const/16 v34, 0x1

    const/16 v35, 0x1

    const/16 v36, 0x1

    const/16 v37, 0x1

    move-object/from16 v26, v3

    invoke-direct/range {v26 .. v39}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;-><init>(ZZZZZZZZZZZILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 679
    .local v3, "cloneOpts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    sget-object v5, Lcom/twntool/editor/core/CloneEngine;->INSTANCE:Lcom/twntool/editor/core/CloneEngine;

    invoke-virtual {v5, v1, v4, v3}, Lcom/twntool/editor/core/CloneEngine;->cloneDecoration(Ljava/lang/String;Ljava/lang/String;Lcom/twntool/editor/core/CloneEngine$CloneOptions;)Lcom/twntool/editor/core/CloneEngine$CloneResult;

    move-result-object v5

    .line 680
    .local v5, "cloneResult":Lcom/twntool/editor/core/CloneEngine$CloneResult;
    invoke-virtual {v5}, Lcom/twntool/editor/core/CloneEngine$CloneResult;->getXml()Ljava/lang/String;

    move-result-object v4

    .line 681
    const-string v7, "clone_log_done"

    const/4 v8, 0x0

    new-array v14, v8, [Ljava/lang/Object;

    invoke-direct {v0, v7, v14}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 682
    .local v7, "cloneDoneSuffix":Ljava/lang/String;
    invoke-virtual {v5}, Lcom/twntool/editor/core/CloneEngine$CloneResult;->getLog()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_4fa
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_519

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .line 683
    .local v14, "line":Ljava/lang/String;
    move-object/from16 v19, v3

    const/4 v1, 0x2

    const/4 v3, 0x0

    const/4 v15, 0x0

    .end local v3  # "cloneOpts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    .local v19, "cloneOpts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    invoke-static {v14, v7, v3, v1, v15}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v22

    if-nez v22, :cond_514

    invoke-interface {v2, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_514
    move-object/from16 v1, p2

    move-object/from16 v3, v19

    goto :goto_4fa

    .line 686
    .end local v14  # "line":Ljava/lang/String;
    .end local v19  # "cloneOpts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    .restart local v3  # "cloneOpts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    :cond_519
    move-object/from16 v19, v3

    const/4 v3, 0x0

    .end local v3  # "cloneOpts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    .restart local v19  # "cloneOpts":Lcom/twntool/editor/core/CloneEngine$CloneOptions;
    const-string v1, "desban_log_etapa1_done"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {v0, v1, v3}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 687
    new-instance v1, Lcom/twntool/editor/core/DesbanEngine$DesbanResult;

    const/4 v3, 0x1

    invoke-direct {v1, v4, v2, v3}, Lcom/twntool/editor/core/DesbanEngine$DesbanResult;-><init>(Ljava/lang/String;Ljava/util/List;Z)V

    return-object v1
.end method

.method public final applyEtapa2(Ljava/lang/String;Ljava/lang/String;)Lcom/twntool/editor/core/DesbanEngine$DesbanResult;
    .registers 26
    .param p1, "myXml"  # Ljava/lang/String;
    .param p2, "friendXml"  # Ljava/lang/String;

    move-object/from16 v6, p0

    move-object/from16 v7, p2

    const-string v0, "myXml"

    move-object/from16 v8, p1

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "friendXml"

    invoke-static {v7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 695
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v9, v0

    check-cast v9, Ljava/util/List;

    .line 696
    .local v9, "log":Ljava/util/List;
    move-object/from16 v0, p1

    .line 698
    .local v0, "result":Ljava/lang/String;
    const/4 v10, 0x0

    new-array v1, v10, [Ljava/lang/Object;

    const-string v2, "desban_step_e2_city"

    invoke-direct {v6, v2, v1}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "i:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v9, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 699
    invoke-direct {v6, v7, v0}, Lcom/twntool/editor/core/DesbanEngine;->cloneTownAndBuildings(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    move-object v11, v2

    check-cast v11, Ljava/lang/String;

    .local v11, "out1":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v12

    .local v12, "ok1":Z
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    move-object v13, v1

    check-cast v13, Ljava/lang/String;

    .line 700
    .local v13, "msg1":Ljava/lang/String;
    move-object v0, v11

    .line 701
    const-string v14, "w:"

    const-string v15, "s:"

    if-eqz v12, :cond_5e

    move-object v1, v15

    goto :goto_5f

    :cond_5e
    move-object v1, v14

    :goto_5f
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v9, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 703
    const-string v1, "desban_step_e2_global"

    new-array v2, v10, [Ljava/lang/Object;

    invoke-direct {v6, v1, v2}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v9, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 704
    invoke-direct {v6, v7, v0}, Lcom/twntool/editor/core/DesbanEngine;->cloneGlobalVarsECoupons(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    move-object/from16 v16, v2

    check-cast v16, Ljava/lang/String;

    .local v16, "out2":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    move-object v5, v1

    check-cast v5, Ljava/lang/String;

    .line 705
    .local v5, "msg2":Ljava/lang/String;
    move-object/from16 v0, v16

    .line 706
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v9, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 708
    const-string v1, "desban_step_e2_zoo"

    new-array v2, v10, [Ljava/lang/Object;

    invoke-direct {v6, v1, v2}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v9, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 710
    const/4 v1, 0x3

    new-array v1, v1, [Lkotlin/Triple;

    new-instance v2, Lkotlin/Triple;

    const-string v3, "</Zoo>"

    const-string v4, "Zoo"

    move-object/from16 v17, v0

    .end local v0  # "result":Ljava/lang/String;
    .local v17, "result":Ljava/lang/String;
    const-string v0, "<Zoo"

    invoke-direct {v2, v0, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    aput-object v2, v1, v10

    .line 711
    new-instance v0, Lkotlin/Triple;

    const-string v2, "</ZooInfo>"

    const-string v3, "ZooInfo"

    const-string v4, "<ZooInfo"

    invoke-direct {v0, v4, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v4, 0x1

    aput-object v0, v1, v4

    .line 710
    nop

    .line 712
    new-instance v0, Lkotlin/Triple;

    const-string v2, "</ZooQuests>"

    const-string v3, "ZooQuests"

    const-string v4, "<ZooQuests"

    invoke-direct {v0, v4, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v2, 0x2

    aput-object v0, v1, v2

    .line 710
    nop

    .line 709
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v19

    move-object/from16 v4, v17

    .end local v17  # "result":Ljava/lang/String;
    .local v4, "result":Ljava/lang/String;
    :goto_10e
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_178

    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lkotlin/Triple;

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    move-object/from16 v17, v1

    check-cast v17, Ljava/lang/String;

    .local v17, "open":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v1

    move-object/from16 v20, v1

    check-cast v20, Ljava/lang/String;

    .local v20, "close":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v21, v0

    check-cast v21, Ljava/lang/String;

    .line 714
    .local v21, "label":Ljava/lang/String;
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object v2, v4

    move-object/from16 v3, v17

    move-object/from16 v22, v4

    .end local v4  # "result":Ljava/lang/String;
    .local v22, "result":Ljava/lang/String;
    move-object/from16 v4, v20

    move-object/from16 v18, v5

    .end local v5  # "msg2":Ljava/lang/String;
    .local v18, "msg2":Ljava/lang/String;
    move-object/from16 v5, v21

    invoke-direct/range {v0 .. v5}, Lcom/twntool/editor/core/DesbanEngine;->cloneBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "newOut":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .local v2, "ok":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 715
    .local v0, "msg":Ljava/lang/String;
    move-object v4, v1

    .line 716
    .end local v22  # "result":Ljava/lang/String;
    .restart local v4  # "result":Ljava/lang/String;
    if-eqz v2, :cond_160

    move-object v3, v15

    goto :goto_161

    :cond_160
    move-object v3, v14

    :goto_161
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v9, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v5, v18

    .end local v0  # "msg":Ljava/lang/String;
    .end local v1  # "newOut":Ljava/lang/String;
    .end local v2  # "ok":Z
    goto :goto_10e

    .line 719
    .end local v17  # "open":Ljava/lang/String;
    .end local v18  # "msg2":Ljava/lang/String;
    .end local v20  # "close":Ljava/lang/String;
    .end local v21  # "label":Ljava/lang/String;
    .restart local v5  # "msg2":Ljava/lang/String;
    :cond_178
    const-string v0, "desban_log_etapa2_done"

    new-array v1, v10, [Ljava/lang/Object;

    invoke-direct {v6, v0, v1}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v9, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 720
    new-instance v0, Lcom/twntool/editor/core/DesbanEngine$DesbanResult;

    const/4 v1, 0x1

    invoke-direct {v0, v4, v9, v1}, Lcom/twntool/editor/core/DesbanEngine$DesbanResult;-><init>(Ljava/lang/String;Ljava/util/List;Z)V

    return-object v0
.end method

.method public final applyEtapa3(Ljava/lang/String;Ljava/lang/String;)Lcom/twntool/editor/core/DesbanEngine$DesbanResult;
    .registers 35
    .param p1, "myXml"  # Ljava/lang/String;
    .param p2, "friendXml"  # Ljava/lang/String;

    move-object/from16 v8, p0

    move-object/from16 v9, p2

    const-string v0, "myXml"

    move-object/from16 v10, p1

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "friendXml"

    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 728
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v11, v0

    check-cast v11, Ljava/util/List;

    .line 729
    .local v11, "log":Ljava/util/List;
    move-object/from16 v0, p1

    .line 731
    .local v0, "result":Ljava/lang/String;
    const/4 v12, 0x0

    new-array v1, v12, [Ljava/lang/Object;

    const-string v2, "desban_step_e3_blocks"

    invoke-direct {v8, v2, v1}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "i:"

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v11, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 734
    invoke-direct {v8, v9, v0}, Lcom/twntool/editor/core/DesbanEngine;->cloneArtInfo(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    move-object v14, v2

    check-cast v14, Ljava/lang/String;

    .local v14, "rArt":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v15

    .local v15, "okArt":Z
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    move-object v7, v1

    check-cast v7, Ljava/lang/String;

    .line 735
    .local v7, "msgArt":Ljava/lang/String;
    move-object v0, v14

    .line 736
    const-string v16, "w:"

    const-string v6, "s:"

    if-eqz v15, :cond_5e

    move-object v1, v6

    goto :goto_60

    :cond_5e
    move-object/from16 v1, v16

    :goto_60
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v11, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 740
    const/16 v1, 0xa

    new-array v1, v1, [Lkotlin/Triple;

    new-instance v2, Lkotlin/Triple;

    const-string v3, "</Trains>"

    const-string v4, "Trains"

    const-string v5, "<Trains"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    aput-object v2, v1, v12

    .line 741
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</IslandsInfo>"

    const-string v4, "IslandsInfo"

    const-string v5, "<IslandsInfo"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v5, 0x1

    aput-object v2, v1, v5

    .line 740
    nop

    .line 742
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</Minigames>"

    const-string v4, "Minigames"

    const-string v5, "<Minigames"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v5, 0x2

    aput-object v2, v1, v5

    .line 740
    nop

    .line 743
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</DataStoreCollapseQuests>"

    const-string v4, "DSCollapseQuests"

    const-string v5, "<DataStoreCollapseQuests"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/16 v19, 0x3

    aput-object v2, v1, v19

    .line 740
    nop

    .line 744
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</QuestsBook>"

    const-string v4, "QuestsBook"

    const-string v5, "<QuestsBook"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/16 v20, 0x4

    aput-object v2, v1, v20

    .line 740
    nop

    .line 745
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</DataStoreCollection>"

    const-string v4, "DSCollection"

    const-string v5, "<DataStoreCollection"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v5, 0x5

    aput-object v2, v1, v5

    .line 740
    nop

    .line 746
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</MapOrders>"

    const-string v4, "MapOrders"

    const-string v5, "<MapOrders"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v3, 0x6

    aput-object v2, v1, v3

    .line 740
    nop

    .line 747
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</Helic>"

    const-string v4, "Helic"

    const-string v5, "<Helic"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v3, 0x7

    aput-object v2, v1, v3

    .line 740
    nop

    .line 748
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</SeasonTicket>"

    const-string v4, "SeasonTicket"

    const-string v5, "<SeasonTicket"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/16 v3, 0x8

    aput-object v2, v1, v3

    .line 740
    nop

    .line 749
    new-instance v2, Lkotlin/Triple;

    const-string v3, "</LevelInfo>"

    const-string v4, "LevelInfo"

    const-string v5, "<LevelInfo"

    invoke-direct {v2, v5, v3, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/16 v3, 0x9

    aput-object v2, v1, v3

    .line 740
    nop

    .line 739
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v22

    .line 753
    .local v22, "singleBlocks":Ljava/util/List;
    invoke-interface/range {v22 .. v22}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v23

    move-object v5, v0

    .end local v0  # "result":Ljava/lang/String;
    .local v5, "result":Ljava/lang/String;
    :goto_119
    invoke-interface/range {v23 .. v23}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_186

    invoke-interface/range {v23 .. v23}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lkotlin/Triple;

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    move-object/from16 v24, v1

    check-cast v24, Ljava/lang/String;

    .local v24, "open":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v1

    move-object/from16 v25, v1

    check-cast v25, Ljava/lang/String;

    .local v25, "close":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v26, v0

    check-cast v26, Ljava/lang/String;

    .line 754
    .local v26, "label":Ljava/lang/String;
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object v2, v5

    move-object/from16 v3, v24

    move-object/from16 v4, v25

    move-object v12, v5

    move-object/from16 v17, v6

    const/4 v6, 0x2

    .end local v5  # "result":Ljava/lang/String;
    .local v12, "result":Ljava/lang/String;
    move-object/from16 v5, v26

    invoke-direct/range {v0 .. v5}, Lcom/twntool/editor/core/DesbanEngine;->cloneBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "newOut":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .local v2, "ok":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 755
    .local v0, "msg":Ljava/lang/String;
    move-object v5, v1

    .line 756
    .end local v12  # "result":Ljava/lang/String;
    .restart local v5  # "result":Ljava/lang/String;
    if-eqz v2, :cond_16c

    move-object/from16 v3, v17

    goto :goto_16e

    :cond_16c
    move-object/from16 v3, v16

    :goto_16e
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v11, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v6, v17

    const/4 v12, 0x0

    .end local v0  # "msg":Ljava/lang/String;
    .end local v1  # "newOut":Ljava/lang/String;
    .end local v2  # "ok":Z
    goto :goto_119

    .line 760
    .end local v24  # "open":Ljava/lang/String;
    .end local v25  # "close":Ljava/lang/String;
    .end local v26  # "label":Ljava/lang/String;
    :cond_186
    move-object v12, v5

    move-object/from16 v17, v6

    const/4 v6, 0x2

    .end local v5  # "result":Ljava/lang/String;
    .restart local v12  # "result":Ljava/lang/String;
    invoke-direct {v8, v9, v12}, Lcom/twntool/editor/core/DesbanEngine;->cloneUpgradeBlock(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    move-object/from16 v18, v1

    check-cast v18, Ljava/lang/String;

    .local v18, "rUp":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v23

    .local v23, "okUp":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    move-object v5, v0

    check-cast v5, Ljava/lang/String;

    .line 761
    .local v5, "msgUp":Ljava/lang/String;
    move-object/from16 v0, v18

    .line 762
    .end local v12  # "result":Ljava/lang/String;
    .local v0, "result":Ljava/lang/String;
    if-eqz v23, :cond_1ae

    move-object/from16 v1, v17

    goto :goto_1b0

    :cond_1ae
    move-object/from16 v1, v16

    :goto_1b0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v11, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 766
    new-array v1, v6, [[Ljava/lang/String;

    const/4 v2, 0x5

    new-array v3, v2, [Ljava/lang/String;

    const-string v2, "<AirInfo"

    const/4 v4, 0x0

    aput-object v2, v3, v4

    const-string v2, "</AirInfo>"

    const/4 v12, 0x1

    aput-object v2, v3, v12

    const-string v2, "<AirOrders"

    aput-object v2, v3, v6

    const-string v2, "</AirOrders>"

    aput-object v2, v3, v19

    const-string v2, "AirInfo+Orders"

    aput-object v2, v3, v20

    aput-object v3, v1, v4

    .line 767
    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "<DailyBonusRewardDay6"

    aput-object v3, v2, v4

    const-string v3, "</DailyBonusRewardDay6>"

    aput-object v3, v2, v12

    .line 768
    const-string v3, "<VipDailyBonusRewardDay6"

    aput-object v3, v2, v6

    .line 767
    nop

    .line 768
    const-string v3, "</VipDailyBonusRewardDay6>"

    aput-object v3, v2, v19

    .line 767
    nop

    .line 768
    const-string v3, "DailyBonus"

    aput-object v3, v2, v20

    .line 767
    aput-object v2, v1, v12

    .line 766
    check-cast v1, [Ljava/lang/Object;

    .line 765
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v21

    .line 770
    .local v21, "pairs":Ljava/util/List;
    invoke-interface/range {v21 .. v21}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v24

    move-object v4, v0

    .end local v0  # "result":Ljava/lang/String;
    .local v4, "result":Ljava/lang/String;
    :goto_207
    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_277

    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v25, v0

    check-cast v25, [Ljava/lang/String;

    .line 771
    .local v25, "p":[Ljava/lang/String;
    const/4 v0, 0x0

    aget-object v3, v25, v0

    aget-object v26, v25, v12

    aget-object v27, v25, v6

    aget-object v28, v25, v19

    aget-object v29, v25, v20

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object v2, v4

    move-object v12, v4

    .end local v4  # "result":Ljava/lang/String;
    .restart local v12  # "result":Ljava/lang/String;
    move-object/from16 v4, v26

    move-object/from16 v26, v5

    .end local v5  # "msgUp":Ljava/lang/String;
    .local v26, "msgUp":Ljava/lang/String;
    move-object/from16 v5, v27

    move-object/from16 v10, v17

    move/from16 v17, v6

    move-object/from16 v6, v28

    move-object/from16 v27, v7

    .end local v7  # "msgArt":Ljava/lang/String;
    .local v27, "msgArt":Ljava/lang/String;
    move-object/from16 v7, v29

    invoke-direct/range {v0 .. v7}, Lcom/twntool/editor/core/DesbanEngine;->cloneXmlBlockPair(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .restart local v1  # "newOut":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .restart local v2  # "ok":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 772
    .local v0, "msg":Ljava/lang/String;
    move-object v4, v1

    .line 773
    .end local v12  # "result":Ljava/lang/String;
    .restart local v4  # "result":Ljava/lang/String;
    if-eqz v2, :cond_255

    move-object v6, v10

    goto :goto_257

    :cond_255
    move-object/from16 v6, v16

    :goto_257
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v11, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move/from16 v6, v17

    move-object/from16 v5, v26

    move-object/from16 v7, v27

    const/4 v12, 0x1

    move-object/from16 v17, v10

    move-object/from16 v10, p1

    .end local v0  # "msg":Ljava/lang/String;
    .end local v1  # "newOut":Ljava/lang/String;
    .end local v2  # "ok":Z
    goto :goto_207

    .line 777
    .end local v25  # "p":[Ljava/lang/String;
    .end local v26  # "msgUp":Ljava/lang/String;
    .end local v27  # "msgArt":Ljava/lang/String;
    .restart local v5  # "msgUp":Ljava/lang/String;
    .restart local v7  # "msgArt":Ljava/lang/String;
    :cond_277
    move-object v12, v4

    move-object/from16 v26, v5

    move-object/from16 v27, v7

    move-object/from16 v10, v17

    .end local v4  # "result":Ljava/lang/String;
    .end local v5  # "msgUp":Ljava/lang/String;
    .end local v7  # "msgArt":Ljava/lang/String;
    .restart local v12  # "result":Ljava/lang/String;
    .restart local v26  # "msgUp":Ljava/lang/String;
    .restart local v27  # "msgArt":Ljava/lang/String;
    invoke-direct {v8, v9, v12}, Lcom/twntool/editor/core/DesbanEngine;->cloneBarnItems(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "rBarn":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .local v2, "okBarn":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 778
    .local v0, "msgBarn":Ljava/lang/String;
    move-object v3, v1

    .line 779
    .end local v12  # "result":Ljava/lang/String;
    .local v3, "result":Ljava/lang/String;
    if-eqz v2, :cond_29d

    move-object v6, v10

    goto :goto_29f

    :cond_29d
    move-object/from16 v6, v16

    :goto_29f
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v11, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 782
    invoke-direct {v8, v9, v3}, Lcom/twntool/editor/core/DesbanEngine;->cloneMatch3AdvantagesBoosters(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .local v5, "rM3":Ljava/lang/String;
    invoke-virtual {v4}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Boolean;

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .local v6, "okM3":Z
    invoke-virtual {v4}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 783
    .local v4, "msgM3":Ljava/lang/String;
    move-object v3, v5

    .line 784
    if-eqz v6, :cond_2d2

    move-object v7, v10

    goto :goto_2d4

    :cond_2d2
    move-object/from16 v7, v16

    :goto_2d4
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v11, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 787
    invoke-direct {v8, v9, v3}, Lcom/twntool/editor/core/DesbanEngine;->cloneAlterarQuantidadeVars(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .local v12, "rAlt":Ljava/lang/String;
    invoke-virtual {v7}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v17

    check-cast v17, Ljava/lang/Boolean;

    invoke-virtual/range {v17 .. v17}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v17

    .local v17, "okAlt":Z
    invoke-virtual {v7}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 788
    .local v7, "msgAlt":Ljava/lang/String;
    move-object v3, v12

    .line 789
    move-object/from16 v19, v0

    if-eqz v17, :cond_309

    move-object v0, v10

    goto :goto_30b

    :cond_309
    move-object/from16 v0, v16

    .end local v0  # "msgBarn":Ljava/lang/String;
    .local v19, "msgBarn":Ljava/lang/String;
    :goto_30b
    move-object/from16 v20, v1

    .end local v1  # "rBarn":Ljava/lang/String;
    .local v20, "rBarn":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v11, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 792
    invoke-direct {v8, v9, v3}, Lcom/twntool/editor/core/DesbanEngine;->cloneGlobalBlock(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "rApp":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v24

    check-cast v24, Ljava/lang/Boolean;

    invoke-virtual/range {v24 .. v24}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v24

    .local v24, "okApp":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 793
    .local v0, "msgApp":Ljava/lang/String;
    move-object v3, v1

    .line 794
    move-object/from16 v25, v1

    if-eqz v24, :cond_342

    move-object v1, v10

    goto :goto_344

    :cond_342
    move-object/from16 v1, v16

    .end local v1  # "rApp":Ljava/lang/String;
    .local v25, "rApp":Ljava/lang/String;
    :goto_344
    move/from16 v16, v2

    .end local v2  # "okBarn":Z
    .local v16, "okBarn":Z
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v11, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 797
    const-string v1, "desban_step_e3_achievements"

    move-object/from16 v28, v0

    const/4 v2, 0x0

    .end local v0  # "msgApp":Ljava/lang/String;
    .local v28, "msgApp":Ljava/lang/String;
    new-array v0, v2, [Ljava/lang/Object;

    invoke-direct {v8, v1, v0}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v11, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 798
    invoke-direct {v8, v3}, Lcom/twntool/editor/core/DesbanEngine;->processUnlockAchievements(Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "rAch":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    .local v2, "achUpd":I
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    .line 799
    .local v0, "achCri":I
    move-object v3, v1

    .line 800
    add-int v29, v2, v0

    invoke-static/range {v29 .. v29}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v29

    move/from16 v30, v0

    .end local v0  # "achCri":I
    .local v30, "achCri":I
    filled-new-array/range {v29 .. v29}, [Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v29, v1

    .end local v1  # "rAch":Ljava/lang/String;
    .local v29, "rAch":Ljava/lang/String;
    const-string v1, "desban_log_achievements_done"

    invoke-direct {v8, v1, v0}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v11, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 803
    invoke-direct {v8, v9, v3}, Lcom/twntool/editor/core/DesbanEngine;->cloneGlobalVarsECoupons(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "rGv":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 804
    .local v0, "msgGv":Ljava/lang/String;
    move-object v3, v1

    .line 805
    move-object/from16 v31, v1

    .end local v1  # "rGv":Ljava/lang/String;
    .local v31, "rGv":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v11, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 807
    const-string v1, "desban_log_etapa3_done"

    const/4 v13, 0x0

    new-array v13, v13, [Ljava/lang/Object;

    invoke-direct {v8, v1, v13}, Lcom/twntool/editor/core/DesbanEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v11, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 808
    new-instance v1, Lcom/twntool/editor/core/DesbanEngine$DesbanResult;

    const/4 v10, 0x1

    invoke-direct {v1, v3, v11, v10}, Lcom/twntool/editor/core/DesbanEngine$DesbanResult;-><init>(Ljava/lang/String;Ljava/util/List;Z)V

    return-object v1
.end method
