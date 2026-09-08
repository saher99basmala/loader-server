# classes4.dex

.class public final Lcom/twntool/editor/core/CloneEngine;
.super Ljava/lang/Object;
.source "CloneEngine.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/twntool/editor/core/CloneEngine$CloneOptions;,
        Lcom/twntool/editor/core/CloneEngine$CloneResult;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nCloneEngine.kt\nKotlin\n*S Kotlin\n*F\n+ 1 CloneEngine.kt\ncom/twntool/editor/core/CloneEngine\n+ 2 Maps.kt\nkotlin/collections/MapsKt__MapsKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,435:1\n487#2,7:436\n1053#3:443\n*S KotlinDebug\n*F\n+ 1 CloneEngine.kt\ncom/twntool/editor/core/CloneEngine\n*L\n156#1:436,7\n158#1:443\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000F\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0003\n\u0002\u0010\u000e\n\u0002\b\u0002\n\u0002\u0010\u0011\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0002\u0010\b\n\u0002\b\u0005\n\u0002\u0010\u000b\n\u0002\b\u0007\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0018\u0002\n\u0002\b\u0006\bÇ\u0002\u0018\u00002\u00020\u0001:\u0002&\'B\t\b\u0002¢\u0006\u0004\b\u0002\u0010\u0003J)\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00052\u0012\u0010\u0007\u001a\n\u0012\u0006\b\u0001\u0012\u00020\u00010\b\"\u00020\u0001H\u0002¢\u0006\u0002\u0010\tJ\u0012\u0010\n\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u000b\u001a\u00020\u0005H\u0002J>\u0010\f\u001a\u0016\u0012\u0006\u0012\u0004\u0018\u00010\u0005\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u000e0\r2\u0006\u0010\u000b\u001a\u00020\u00052\u0006\u0010\u000f\u001a\u00020\u00052\u0006\u0010\u0010\u001a\u00020\u00052\b\b\u0002\u0010\u0011\u001a\u00020\u000eH\u0002J\u0010\u0010\u0012\u001a\u00020\u000e2\u0006\u0010\u000b\u001a\u00020\u0005H\u0002JB\u0010\u0013\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u0014\u0012\u0004\u0012\u00020\u00050\r2\u0006\u0010\u0015\u001a\u00020\u00052\u0006\u0010\u0016\u001a\u00020\u00052\u0006\u0010\u0017\u001a\u00020\u00052\u0006\u0010\u0010\u001a\u00020\u00052\u0006\u0010\u0018\u001a\u00020\u0005H\u0002J:\u0010\u0019\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u0014\u0012\u0004\u0012\u00020\u00050\r2\u0006\u0010\u0015\u001a\u00020\u00052\u0006\u0010\u0016\u001a\u00020\u00052\u0006\u0010\u001a\u001a\u00020\u00052\u0006\u0010\u0018\u001a\u00020\u0005H\u0002J$\u0010\u001b\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\u001c2\u0006\u0010\u0015\u001a\u00020\u00052\u0006\u0010\u0016\u001a\u00020\u0005H\u0002J \u0010\u001d\u001a\u00020\u001e2\u0006\u0010\u001f\u001a\u00020\u00052\u0006\u0010 \u001a\u00020\u00052\b\b\u0002\u0010!\u001a\u00020\"J\u001a\u0010#\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u000e0\u001c2\u0006\u0010\u000b\u001a\u00020\u0005JB\u0010$\u001a\u0014\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u0014\u0012\u0004\u0012\u00020\u00050\r2\u0006\u0010\u0015\u001a\u00020\u00052\u0006\u0010\u0016\u001a\u00020\u00052\u0006\u0010\u0017\u001a\u00020\u00052\u0006\u0010\u0010\u001a\u00020\u00052\u0006\u0010%\u001a\u00020\u0005H\u0002¨\u0006("
    }
    d2 = {
        "Lcom/twntool/editor/core/CloneEngine;",
        "",
        "<init>",
        "()V",
        "t",
        "",
        "key",
        "args",
        "",
        "(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;",
        "extractUserId",
        "xml",
        "extractBlock",
        "Lkotlin/Triple;",
        "",
        "tagOpen",
        "tagClose",
        "fromPos",
        "positionAfterZoo",
        "cloneXmlBlock",
        "",
        "src",
        "tgt",
        "tagOpenPrefix",
        "labelKey",
        "cloneDataElem",
        "name",
        "cloneAvatars",
        "Lkotlin/Pair;",
        "cloneDecoration",
        "Lcom/twntool/editor/core/CloneEngine$CloneResult;",
        "srcXml",
        "tgtXml",
        "options",
        "Lcom/twntool/editor/core/CloneEngine$CloneOptions;",
        "fecharQuestsTutorialInicial",
        "cloneXmlBlockRaw",
        "label",
        "CloneOptions",
        "CloneResult",
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

.field public static final INSTANCE:Lcom/twntool/editor/core/CloneEngine;


# direct methods
.method public static synthetic $r8$lambda$2JnBJtLZPewgp6BwdebjdStsCnM(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/CloneEngine;->fecharQuestsTutorialInicial$lambda$5(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$9xB_pF3lrVXPpYJpX5MMRQJBEqM(Lkotlin/Pair;)Ljava/lang/CharSequence;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/CloneEngine;->cloneAvatars$lambda$4(Lkotlin/Pair;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$WlCcPRQ_BziOQeOP9ebLJw5XglQ(Ljava/util/Map;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 2

    invoke-static {p0, p1}, Lcom/twntool/editor/core/CloneEngine;->cloneAvatars$lambda$0(Ljava/util/Map;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$obFNmXX5kU9kb-SC3wpoiRjtwKY(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Lcom/twntool/editor/core/CloneEngine;->cloneAvatars$lambda$1(Lkotlin/text/MatchResult;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$wBIz07OGi6kcsquG_yhUClag0HY(ILkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 2

    invoke-static {p0, p1}, Lcom/twntool/editor/core/CloneEngine;->fecharQuestsTutorialInicial$lambda$6(ILkotlin/text/MatchResult;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .registers 1

    new-instance v0, Lcom/twntool/editor/core/CloneEngine;

    invoke-direct {v0}, Lcom/twntool/editor/core/CloneEngine;-><init>()V

    sput-object v0, Lcom/twntool/editor/core/CloneEngine;->INSTANCE:Lcom/twntool/editor/core/CloneEngine;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final cloneAvatars(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;
    .registers 24
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 140
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v2, Ljava/util/Map;

    .line 141
    .local v2, "avataresSrc":Ljava/util/Map;
    new-instance v3, Lkotlin/text/Regex;

    const-string v4, "<Var\\s+name=\"(Unlocked_ava\\d+)\"\\s+v=\"([^\"]*)\"[^/]*/>"

    invoke-direct {v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object/from16 v5, p1

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v3, v5, v6, v7, v8}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v3

    invoke-interface {v3}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_21
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    const/4 v9, 0x1

    if-eqz v5, :cond_42

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lkotlin/text/MatchResult;

    .line 142
    .local v5, "m":Lkotlin/text/MatchResult;
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v10

    invoke-interface {v10, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    invoke-interface {v5}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v10

    invoke-interface {v10, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    invoke-interface {v2, v9, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_21

    .line 144
    .end local v5  # "m":Lkotlin/text/MatchResult;
    :cond_42
    invoke-interface {v2}, Ljava/util/Map;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_55

    const-string v3, "clone_log_no_avatars"

    new-array v4, v6, [Ljava/lang/Object;

    invoke-direct {v0, v3, v4}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 147
    :cond_55
    new-instance v3, Lkotlin/text/Regex;

    invoke-direct {v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    new-instance v5, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda0;

    invoke-direct {v5, v2}, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda0;-><init>(Ljava/util/Map;)V

    invoke-virtual {v3, v4, v5}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v3

    .line 154
    .local v3, "out":Ljava/lang/String;
    new-instance v4, Lkotlin/text/Regex;

    const-string v5, "<Var\\s+name=\"(Unlocked_ava\\d+)\""

    invoke-direct {v4, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v5, v3

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v4, v5, v6, v7, v8}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v4

    new-instance v5, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda1;

    invoke-direct {v5}, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda1;-><init>()V

    .line 155
    invoke-static {v4, v5}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v4

    invoke-static {v4}, Lkotlin/sequences/SequencesKt;->toSet(Lkotlin/sequences/Sequence;)Ljava/util/Set;

    move-result-object v4

    .line 154
    nop

    .line 156
    .local v4, "presentes":Ljava/util/Set;
    move-object v5, v2

    .local v5, "$this$filterKeys$iv":Ljava/util/Map;
    const/4 v10, 0x0

    .line 436
    .local v10, "$i$f$filterKeys":I
    new-instance v11, Ljava/util/LinkedHashMap;

    invoke-direct {v11}, Ljava/util/LinkedHashMap;-><init>()V

    .line 437
    .local v11, "result$iv":Ljava/util/LinkedHashMap;
    invoke-interface {v5}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v12

    invoke-interface {v12}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v12

    :cond_91
    :goto_91
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_b8

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/util/Map$Entry;

    .line 438
    .local v13, "entry$iv":Ljava/util/Map$Entry;
    invoke-interface {v13}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .local v14, "it":Ljava/lang/String;
    const/4 v15, 0x0

    .line 156
    .local v15, "$i$a$-filterKeys-CloneEngine$cloneAvatars$faltando$1":I
    invoke-interface {v4, v14}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v16

    .line 438
    .end local v14  # "it":Ljava/lang/String;
    .end local v15  # "$i$a$-filterKeys-CloneEngine$cloneAvatars$faltando$1":I
    xor-int/lit8 v14, v16, 0x1

    if-eqz v14, :cond_91

    .line 439
    invoke-interface {v13}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v14

    invoke-interface {v13}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v15

    invoke-virtual {v11, v14, v15}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_91

    .line 442
    .end local v13  # "entry$iv":Ljava/util/Map$Entry;
    :cond_b8
    move-object v5, v11

    check-cast v5, Ljava/util/Map;

    .line 156
    .end local v5  # "$this$filterKeys$iv":Ljava/util/Map;
    .end local v10  # "$i$f$filterKeys":I
    .end local v11  # "result$iv":Ljava/util/LinkedHashMap;
    nop

    .line 157
    .local v5, "faltando":Ljava/util/Map;
    invoke-interface {v5}, Ljava/util/Map;->isEmpty()Z

    move-result v10

    xor-int/2addr v9, v10

    if-eqz v9, :cond_190

    .line 158
    invoke-static {v5}, Lkotlin/collections/MapsKt;->toList(Ljava/util/Map;)Ljava/util/List;

    move-result-object v9

    check-cast v9, Ljava/lang/Iterable;

    .local v9, "$this$sortedBy$iv":Ljava/lang/Iterable;
    const/4 v10, 0x0

    .line 443
    .local v10, "$i$f$sortedBy":I
    new-instance v11, Lcom/twntool/editor/core/CloneEngine$cloneAvatars$$inlined$sortedBy$1;

    invoke-direct {v11}, Lcom/twntool/editor/core/CloneEngine$cloneAvatars$$inlined$sortedBy$1;-><init>()V

    check-cast v11, Ljava/util/Comparator;

    invoke-static {v9, v11}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v9

    .line 158
    .end local v9  # "$this$sortedBy$iv":Ljava/lang/Iterable;
    .end local v10  # "$i$f$sortedBy":I
    nop

    .line 159
    .local v9, "sorted":Ljava/util/List;
    move-object v10, v9

    check-cast v10, Ljava/lang/Iterable;

    const-string v15, "\n"

    move-object v11, v15

    check-cast v11, Ljava/lang/CharSequence;

    new-instance v16, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda2;

    invoke-direct/range {v16 .. v16}, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda2;-><init>()V

    const/16 v17, 0x1e

    const/16 v18, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/16 v19, 0x0

    move-object/from16 v20, v15

    move-object/from16 v15, v19

    invoke-static/range {v10 .. v18}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    .line 162
    .local v10, "novasLinhas":Ljava/lang/String;
    new-instance v11, Lkotlin/text/Regex;

    const-string v12, "</Global\\s*>"

    sget-object v13, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v11, v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v12, v3

    check-cast v12, Ljava/lang/CharSequence;

    invoke-static {v11, v12, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v11

    .line 163
    .local v11, "mG":Lkotlin/text/MatchResult;
    const-string v12, "substring(...)"

    if-eqz v11, :cond_142

    .line 164
    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {v3, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v11}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v7

    invoke-virtual {v7}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v7

    invoke-virtual {v3, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "\n  "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_18f

    .line 166
    :cond_142
    new-instance v13, Lkotlin/text/Regex;

    const-string v14, "</root\\s*>"

    sget-object v15, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v13, v14, v15}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v14, v3

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v13, v14, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 167
    .local v7, "mR":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_18e

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {v3, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {v3, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    move-object/from16 v12, v20

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_18f

    .line 168
    :cond_18e
    move-object v6, v3

    .line 163
    .end local v7  # "mR":Lkotlin/text/MatchResult;
    :goto_18f
    move-object v3, v6

    .line 171
    .end local v9  # "sorted":Ljava/util/List;
    .end local v10  # "novasLinhas":Ljava/lang/String;
    .end local v11  # "mG":Lkotlin/text/MatchResult;
    :cond_190
    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    const-string v7, "clone_log_avatars_done"

    invoke-direct {v0, v7, v6}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v3, v6}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    return-object v6
.end method

.method private static final cloneAvatars$lambda$0(Ljava/util/Map;Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 6
    .param p0, "$avataresSrc"  # Ljava/util/Map;
    .param p1, "mr"  # Lkotlin/text/MatchResult;

    const-string v0, "mr"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 148
    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 149
    .local v0, "nome":Ljava/lang/String;
    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    if-nez v1, :cond_23

    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x2

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 150
    .local v1, "v":Ljava/lang/String;
    :cond_23
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "<Var name=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" v=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" t=\"b\"/>"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    return-object v2
.end method

.method private static final cloneAvatars$lambda$1(Lkotlin/text/MatchResult;)Ljava/lang/String;
    .registers 3
    .param p0, "it"  # Lkotlin/text/MatchResult;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 155
    invoke-interface {p0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private static final cloneAvatars$lambda$4(Lkotlin/Pair;)Ljava/lang/CharSequence;
    .registers 4

    const-string v0, "<destruct>"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 159
    invoke-virtual {p0}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .local v0, "n":Ljava/lang/String;
    invoke-virtual {p0}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    .line 160
    .local p0, "v":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "    <Var name=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" v=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" t=\"b\"/>"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    return-object v1
.end method

.method private final cloneDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 27
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .param p3, "name"  # Ljava/lang/String;
    .param p4, "labelKey"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
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

    .line 99
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    const/4 v2, 0x0

    .line 103
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 99
    new-array v4, v2, [Ljava/lang/Object;

    move-object/from16 v5, p4

    invoke-direct {v0, v5, v4}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 100
    .local v4, "label":Ljava/lang/String;
    sget-object v6, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    move-object/from16 v7, p3

    invoke-virtual {v6, v7}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "<DataElem\\b[^>]*\\bname=\""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "\"[^>]*/>"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 101
    .local v6, "patternStr":Ljava/lang/String;
    new-instance v8, Lkotlin/text/Regex;

    sget-object v9, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v8, v6, v9}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 103
    .local v8, "pattern":Lkotlin/text/Regex;
    move-object/from16 v9, p1

    check-cast v9, Ljava/lang/CharSequence;

    const/4 v10, 0x2

    const/4 v11, 0x0

    invoke-static {v8, v9, v2, v10, v11}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v9

    const-string v12, "clone_log_block_not_found"

    if-nez v9, :cond_55

    new-instance v2, Lkotlin/Triple;

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v9

    invoke-direct {v0, v12, v9}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v2, v1, v3, v9}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v2

    .line 104
    .local v9, "mSrc":Lkotlin/text/MatchResult;
    :cond_55
    invoke-interface {v9}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v13

    .line 105
    .local v13, "novoTag":Ljava/lang/String;
    invoke-static {v13}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 107
    .local v14, "novoTagSafe":Ljava/lang/String;
    move-object v15, v1

    check-cast v15, Ljava/lang/CharSequence;

    invoke-virtual {v8, v15}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v15

    const/16 v16, 0x1

    if-eqz v15, :cond_86

    .line 108
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v8, v2, v14}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 109
    .local v2, "novoTgt":Ljava/lang/String;
    new-instance v3, Lkotlin/Triple;

    invoke-static/range {v16 .. v16}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    const-string v11, "clone_log_block_replaced"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v12

    invoke-direct {v0, v11, v12}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v3, v2, v10, v11}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .line 113
    .end local v2  # "novoTgt":Ljava/lang/String;
    :cond_86
    new-instance v15, Lkotlin/text/Regex;

    const-string v2, "<DataElem\\b[^>]*\\bname=\"PlayerProfile\"[^>]*>"

    sget-object v10, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v15, v2, v10}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v5, 0x2

    const/4 v10, 0x0

    invoke-static {v15, v2, v10, v5, v11}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 114
    .local v2, "mPP":Lkotlin/text/MatchResult;
    const-string v5, "clone_log_block_inserted"

    const-string v10, "substring(...)"

    if-eqz v2, :cond_143

    .line 115
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v15

    add-int/lit8 v15, v15, 0x1

    .line 116
    .local v15, "ppEnd":I
    new-instance v11, Lkotlin/text/Regex;

    move-object/from16 v17, v2

    .end local v2  # "mPP":Lkotlin/text/MatchResult;
    .local v17, "mPP":Lkotlin/text/MatchResult;
    const-string v2, "<DataElem\\b[^>]*\\bname=\"Configs\"[^>]*>"

    move-object/from16 v18, v6

    .end local v6  # "patternStr":Ljava/lang/String;
    .local v18, "patternStr":Ljava/lang/String;
    sget-object v6, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v11, v2, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 117
    invoke-virtual {v1, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Ljava/lang/CharSequence;

    move-object/from16 v19, v8

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    .end local v8  # "pattern":Lkotlin/text/Regex;
    .local v19, "pattern":Lkotlin/text/Regex;
    invoke-static {v11, v2, v6, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 116
    nop

    .line 118
    .local v2, "mCfg":Lkotlin/text/MatchResult;
    if-eqz v2, :cond_13e

    .line 119
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v6

    add-int/2addr v6, v15

    add-int/lit8 v6, v6, 0x1

    .line 120
    .local v6, "absCfgEnd":I
    new-instance v7, Lkotlin/text/Regex;

    const-string v8, "</DataElem\\s*>"

    sget-object v11, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v7, v8, v11}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    invoke-virtual {v1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v8, Ljava/lang/CharSequence;

    move-object/from16 v20, v2

    move-object/from16 v21, v9

    const/4 v2, 0x2

    const/4 v9, 0x0

    const/4 v11, 0x0

    .end local v2  # "mCfg":Lkotlin/text/MatchResult;
    .end local v9  # "mSrc":Lkotlin/text/MatchResult;
    .local v20, "mCfg":Lkotlin/text/MatchResult;
    .local v21, "mSrc":Lkotlin/text/MatchResult;
    invoke-static {v7, v8, v11, v2, v9}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v7

    .line 121
    .local v7, "mClose":Lkotlin/text/MatchResult;
    if-eqz v7, :cond_14b

    .line 122
    invoke-interface {v7}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v2

    invoke-virtual {v2}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v2

    add-int/2addr v2, v6

    .line 123
    .local v2, "pos":I
    invoke-virtual {v1, v11, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, "\n          "

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, "\n        "

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 124
    .local v3, "out":Ljava/lang/String;
    new-instance v8, Lkotlin/Triple;

    invoke-static/range {v16 .. v16}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v10

    invoke-direct {v0, v5, v10}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v8, v3, v9, v5}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v8

    .line 118
    .end local v3  # "out":Ljava/lang/String;
    .end local v6  # "absCfgEnd":I
    .end local v7  # "mClose":Lkotlin/text/MatchResult;
    .end local v20  # "mCfg":Lkotlin/text/MatchResult;
    .end local v21  # "mSrc":Lkotlin/text/MatchResult;
    .local v2, "mCfg":Lkotlin/text/MatchResult;
    .restart local v9  # "mSrc":Lkotlin/text/MatchResult;
    :cond_13e
    move-object/from16 v20, v2

    move-object/from16 v21, v9

    .end local v2  # "mCfg":Lkotlin/text/MatchResult;
    .end local v9  # "mSrc":Lkotlin/text/MatchResult;
    .restart local v20  # "mCfg":Lkotlin/text/MatchResult;
    .restart local v21  # "mSrc":Lkotlin/text/MatchResult;
    goto :goto_14b

    .line 114
    .end local v15  # "ppEnd":I
    .end local v17  # "mPP":Lkotlin/text/MatchResult;
    .end local v18  # "patternStr":Ljava/lang/String;
    .end local v19  # "pattern":Lkotlin/text/Regex;
    .end local v20  # "mCfg":Lkotlin/text/MatchResult;
    .end local v21  # "mSrc":Lkotlin/text/MatchResult;
    .local v2, "mPP":Lkotlin/text/MatchResult;
    .local v6, "patternStr":Ljava/lang/String;
    .restart local v8  # "pattern":Lkotlin/text/Regex;
    .restart local v9  # "mSrc":Lkotlin/text/MatchResult;
    :cond_143
    move-object/from16 v17, v2

    move-object/from16 v18, v6

    move-object/from16 v19, v8

    move-object/from16 v21, v9

    .line 130
    .end local v2  # "mPP":Lkotlin/text/MatchResult;
    .end local v6  # "patternStr":Ljava/lang/String;
    .end local v8  # "pattern":Lkotlin/text/Regex;
    .end local v9  # "mSrc":Lkotlin/text/MatchResult;
    .restart local v17  # "mPP":Lkotlin/text/MatchResult;
    .restart local v18  # "patternStr":Ljava/lang/String;
    .restart local v19  # "pattern":Lkotlin/text/Regex;
    .restart local v21  # "mSrc":Lkotlin/text/MatchResult;
    :cond_14b
    :goto_14b
    new-instance v2, Lkotlin/text/Regex;

    const-string v6, "</root\\s*>"

    sget-object v7, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v2, v6, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v6, v1

    check-cast v6, Ljava/lang/CharSequence;

    const/4 v7, 0x0

    const/4 v8, 0x2

    const/4 v9, 0x0

    invoke-static {v2, v6, v7, v8, v9}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v2

    .line 131
    .local v2, "mRoot":Lkotlin/text/MatchResult;
    if-eqz v2, :cond_1ab

    .line 132
    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v3

    invoke-virtual {v1, v7, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v2}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v6

    invoke-virtual {v6}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v6

    invoke-virtual {v1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, "\n"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 133
    .restart local v3  # "out":Ljava/lang/String;
    new-instance v6, Lkotlin/Triple;

    invoke-static/range {v16 .. v16}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v8

    invoke-direct {v0, v5, v8}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v3, v7, v5}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v6

    .line 135
    .end local v3  # "out":Ljava/lang/String;
    :cond_1ab
    new-instance v5, Lkotlin/Triple;

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v6

    invoke-direct {v0, v12, v6}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v1, v3, v6}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v5
.end method

.method public static synthetic cloneDecoration$default(Lcom/twntool/editor/core/CloneEngine;Ljava/lang/String;Ljava/lang/String;Lcom/twntool/editor/core/CloneEngine$CloneOptions;ILjava/lang/Object;)Lcom/twntool/editor/core/CloneEngine$CloneResult;
    .registers 21

    .line 181
    and-int/lit8 v0, p4, 0x4

    if-eqz v0, :cond_19

    new-instance v0, Lcom/twntool/editor/core/CloneEngine$CloneOptions;

    const/16 v13, 0x7ff

    const/4 v14, 0x0

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

    const/4 v12, 0x0

    move-object v1, v0

    invoke-direct/range {v1 .. v14}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;-><init>(ZZZZZZZZZZZILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto :goto_1b

    :cond_19
    move-object/from16 v0, p3

    :goto_1b
    move-object v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, p2

    invoke-virtual {p0, v2, v3, v0}, Lcom/twntool/editor/core/CloneEngine;->cloneDecoration(Ljava/lang/String;Ljava/lang/String;Lcom/twntool/editor/core/CloneEngine$CloneOptions;)Lcom/twntool/editor/core/CloneEngine$CloneResult;

    move-result-object v0

    return-object v0
.end method

.method private final cloneXmlBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 23
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .param p3, "tagOpenPrefix"  # Ljava/lang/String;
    .param p4, "tagClose"  # Ljava/lang/String;
    .param p5, "labelKey"  # Ljava/lang/String;
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

    .line 75
    move-object/from16 v7, p0

    move-object/from16 v8, p2

    const/4 v9, 0x0

    new-array v0, v9, [Ljava/lang/Object;

    move-object/from16 v10, p5

    invoke-direct {v7, v10, v0}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    .line 76
    .local v11, "label":Ljava/lang/String;
    const/16 v5, 0x8

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    invoke-static/range {v0 .. v6}, Lcom/twntool/editor/core/CloneEngine;->extractBlock$default(Lcom/twntool/editor/core/CloneEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v0

    move-object v12, v0

    check-cast v12, Ljava/lang/String;

    .line 77
    .local v12, "bloco":Ljava/lang/String;
    if-nez v12, :cond_3a

    new-instance v0, Lkotlin/Triple;

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "clone_log_block_not_found"

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v3

    invoke-direct {v7, v2, v3}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v8, v1, v2}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v0

    .line 79
    :cond_3a
    move-object v0, v8

    check-cast v0, Ljava/lang/CharSequence;

    move-object/from16 v1, p3

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v13, 0x2

    const/4 v14, 0x0

    invoke-static {v0, v1, v9, v13, v14}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    const/4 v15, 0x1

    const-string v6, "substring(...)"

    if-eqz v0, :cond_b3

    .line 80
    const/16 v5, 0x8

    const/16 v16, 0x0

    const/4 v4, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move-object v13, v6

    move-object/from16 v6, v16

    invoke-static/range {v0 .. v6}, Lcom/twntool/editor/core/CloneEngine;->extractBlock$default(Lcom/twntool/editor/core/CloneEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "blocoTgt":Ljava/lang/String;
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

    .line 81
    .local v0, "te":I
    if-eqz v1, :cond_b4

    .line 82
    new-instance v3, Lkotlin/Triple;

    invoke-virtual {v8, v9, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v8, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v15}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    .line 83
    const-string v6, "clone_log_block_replaced"

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v9

    invoke-direct {v7, v6, v9}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    .line 82
    invoke-direct {v3, v4, v5, v6}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .line 79
    .end local v0  # "te":I
    .end local v1  # "blocoTgt":Ljava/lang/String;
    .end local v2  # "ts":I
    :cond_b3
    move-object v13, v6

    .line 86
    :cond_b4
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "</root\\s*>"

    sget-object v2, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v0, v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v1, v8

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    invoke-static {v0, v1, v9, v2, v14}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    .line 87
    .local v0, "mRoot":Lkotlin/text/MatchResult;
    const-string v1, "clone_log_block_inserted"

    const-string v2, "\n"

    if-eqz v0, :cond_114

    .line 88
    new-instance v3, Lkotlin/Triple;

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {v8, v9, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v5

    invoke-virtual {v8, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v15}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    .line 89
    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v5

    invoke-direct {v7, v1, v5}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 88
    invoke-direct {v3, v2, v4, v1}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_13a

    .line 91
    :cond_114
    new-instance v3, Lkotlin/Triple;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v15}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v5

    invoke-direct {v7, v1, v5}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v2, v4, v1}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 87
    :goto_13a
    return-object v3
.end method

.method private final cloneXmlBlockRaw(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;
    .registers 16
    .param p1, "src"  # Ljava/lang/String;
    .param p2, "tgt"  # Ljava/lang/String;
    .param p3, "tagOpenPrefix"  # Ljava/lang/String;
    .param p4, "tagClose"  # Ljava/lang/String;
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

    .line 422
    const/16 v5, 0x8

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p3

    move-object v3, p4

    invoke-static/range {v0 .. v6}, Lcom/twntool/editor/core/CloneEngine;->extractBlock$default(Lcom/twntool/editor/core/CloneEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 423
    .local v0, "bloco":Ljava/lang/String;
    const/4 v1, 0x0

    if-nez v0, :cond_32

    new-instance v2, Lkotlin/Triple;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ": não encontrado no doador"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, p2, v1, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v2

    .line 424
    :cond_32
    new-instance v2, Lkotlin/text/Regex;

    sget-object v3, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v3, p3}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v4, p4}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, ".*?"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lkotlin/text/RegexOption;->DOT_MATCHES_ALL:Lkotlin/text/RegexOption;

    invoke-direct {v2, v3, v4}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    .line 425
    .local v2, "tgtRe":Lkotlin/text/Regex;
    invoke-static {v0}, Ljava/util/regex/Matcher;->quoteReplacement(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 426
    .local v3, "safe":Ljava/lang/String;
    move-object v4, p2

    check-cast v4, Ljava/lang/CharSequence;

    invoke-virtual {v2, v4}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v4

    const/4 v5, 0x1

    if-eqz v4, :cond_92

    .line 427
    new-instance v1, Lkotlin/Triple;

    move-object v4, p2

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2, v4, v3}, Lkotlin/text/Regex;->replaceFirst(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ": substituído"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v1, v4, v5, v6}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    goto/16 :goto_130

    .line 429
    :cond_92
    new-instance v4, Lkotlin/text/Regex;

    const-string v6, "</root\\s*>"

    sget-object v7, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v4, v6, v7}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v6, p2

    check-cast v6, Ljava/lang/CharSequence;

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v4, v6, v1, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v4

    .line 430
    .local v4, "mR":Lkotlin/text/MatchResult;
    const-string v6, "\n"

    if-eqz v4, :cond_ff

    new-instance v7, Lkotlin/Triple;

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v8

    invoke-virtual {v8}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v8

    invoke-virtual {p2, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    const-string v8, "substring(...)"

    invoke-static {v1, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v4}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v9

    invoke-virtual {p2, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, ": inserido"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v7, v1, v5, v6}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    move-object v1, v7

    goto :goto_130

    .line 431
    :cond_ff
    new-instance v1, Lkotlin/Triple;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ": appended"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v1, v6, v5, v7}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 426
    .end local v4  # "mR":Lkotlin/text/MatchResult;
    :goto_130
    return-object v1
.end method

.method private final extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;
    .registers 18
    .param p1, "xml"  # Ljava/lang/String;
    .param p2, "tagOpen"  # Ljava/lang/String;
    .param p3, "tagClose"  # Ljava/lang/String;
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

    .line 57
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

    .line 58
    .local v1, "start":I
    const/4 v2, 0x0

    const/4 v3, -0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    if-ne v1, v3, :cond_1c

    new-instance v3, Lkotlin/Triple;

    invoke-direct {v3, v2, v4, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .line 59
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

    .line 60
    .local v5, "endTag":I
    if-ne v5, v3, :cond_31

    new-instance v3, Lkotlin/Triple;

    invoke-direct {v3, v2, v4, v4}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .line 61
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

.method static synthetic extractBlock$default(Lcom/twntool/editor/core/CloneEngine;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)Lkotlin/Triple;
    .registers 7

    .line 54
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_5

    .line 55
    const/4 p4, 0x0

    .line 54
    :cond_5
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/twntool/editor/core/CloneEngine;->extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;

    move-result-object p0

    return-object p0
.end method

.method private final extractUserId(Ljava/lang/String;)Ljava/lang/String;
    .registers 7
    .param p1, "xml"  # Ljava/lang/String;

    .line 46
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "<Object\\b[^>]*\\buser=\"([^\"]+)\""

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v0

    if-eqz v0, :cond_21

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_21

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v4, v0

    check-cast v4, Ljava/lang/String;

    :cond_21
    return-object v4
.end method

.method private static final fecharQuestsTutorialInicial$lambda$5(Lkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 4
    .param p0, "mr"  # Lkotlin/text/MatchResult;

    const-string v0, "mr"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 397
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

    const-string v2, "true"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final fecharQuestsTutorialInicial$lambda$6(ILkotlin/text/MatchResult;)Ljava/lang/CharSequence;
    .registers 6
    .param p0, "$tv"  # I
    .param p1, "mr"  # Lkotlin/text/MatchResult;

    const-string v0, "mr"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 403
    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x2

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_1b

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_1c

    :cond_1b
    const/4 v0, 0x0

    .line 404
    .local v0, "cur":I
    :goto_1c
    if-lt v0, p0, :cond_23

    invoke-interface {p1}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v1

    goto :goto_4a

    .line 405
    :cond_23
    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x1

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {p1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v2

    const/4 v3, 0x3

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_4a
    check-cast v1, Ljava/lang/CharSequence;

    return-object v1
.end method

.method private final positionAfterZoo(Ljava/lang/String;)I
    .registers 8
    .param p1, "xml"  # Ljava/lang/String;

    .line 65
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v4, 0x6

    const/4 v5, 0x0

    const-string v1, "</Zoo>"

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v0 .. v5}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v0

    .line 66
    .local v0, "idx":I
    const/4 v1, -0x1

    if-eq v0, v1, :cond_13

    add-int/lit8 v1, v0, 0x6

    goto :goto_14

    :cond_13
    const/4 v1, 0x0

    :goto_14
    return v1
.end method

.method private final varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .registers 6
    .param p1, "key"  # Ljava/lang/String;
    .param p2, "args"  # [Ljava/lang/Object;

    .line 42
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


# virtual methods
.method public final cloneDecoration(Ljava/lang/String;Ljava/lang/String;Lcom/twntool/editor/core/CloneEngine$CloneOptions;)Lcom/twntool/editor/core/CloneEngine$CloneResult;
    .registers 43
    .param p1, "srcXml"  # Ljava/lang/String;
    .param p2, "tgtXml"  # Ljava/lang/String;
    .param p3, "options"  # Lcom/twntool/editor/core/CloneEngine$CloneOptions;

    move-object/from16 v6, p0

    move-object/from16 v7, p1

    move-object/from16 v8, p2

    const-string v0, "srcXml"

    invoke-static {v7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "tgtXml"

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "options"

    move-object/from16 v9, p3

    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 182
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v10, v0

    check-cast v10, Ljava/util/List;

    .line 185
    .local v10, "log":Ljava/util/List;
    invoke-direct {v6, v8}, Lcom/twntool/editor/core/CloneEngine;->extractUserId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 186
    .local v11, "tgtUser":Ljava/lang/String;
    invoke-direct/range {p0 .. p1}, Lcom/twntool/editor/core/CloneEngine;->extractUserId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 187
    .local v12, "srcUser":Ljava/lang/String;
    const-string v0, "?"

    if-nez v11, :cond_2d

    move-object v1, v0

    goto :goto_2e

    :cond_2d
    move-object v1, v11

    :goto_2e
    if-nez v12, :cond_31

    goto :goto_32

    :cond_31
    move-object v0, v12

    :goto_32
    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "clone_log_user_info"

    invoke-direct {v6, v1, v0}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "i:"

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v10, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 189
    const/4 v0, 0x0

    .line 191
    .local v0, "newXml":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getCloneZoo()Z

    move-result v1

    const-string v15, "w:"

    const-string v5, "s:"

    const/4 v4, 0x0

    if-eqz v1, :cond_12c

    .line 193
    const-string v1, "clone_log_cloning_zoo"

    new-array v2, v4, [Ljava/lang/Object;

    invoke-direct {v6, v1, v2}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v10, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 194
    move-object/from16 v0, p2

    .line 196
    const/4 v1, 0x3

    new-array v1, v1, [Lkotlin/Triple;

    new-instance v2, Lkotlin/Triple;

    const-string v3, "</Zoo>"

    const-string v14, "Zoo"

    move-object/from16 v16, v0

    .end local v0  # "newXml":Ljava/lang/String;
    .local v16, "newXml":Ljava/lang/String;
    const-string v0, "<Zoo"

    invoke-direct {v2, v0, v3, v14}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    aput-object v2, v1, v4

    .line 197
    new-instance v0, Lkotlin/Triple;

    const-string v2, "</ZooInfo>"

    const-string v3, "ZooInfo"

    const-string v14, "<ZooInfo"

    invoke-direct {v0, v14, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v2, 0x1

    aput-object v0, v1, v2

    .line 196
    nop

    .line 198
    new-instance v0, Lkotlin/Triple;

    const-string v2, "</ZooQuests>"

    const-string v3, "ZooQuests"

    const-string v14, "<ZooQuests"

    invoke-direct {v0, v14, v2, v3}, Lkotlin/Triple;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v2, 0x2

    aput-object v0, v1, v2

    .line 196
    nop

    .line 195
    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_b4
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_123

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lkotlin/Triple;

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    move-object/from16 v17, v1

    check-cast v17, Ljava/lang/String;

    .local v17, "open":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v1

    move-object/from16 v18, v1

    check-cast v18, Ljava/lang/String;

    .local v18, "close":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v19, v0

    check-cast v19, Ljava/lang/String;

    .line 200
    .local v19, "lbl":Ljava/lang/String;
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v16

    move-object/from16 v3, v17

    move v9, v4

    move-object/from16 v4, v18

    move-object/from16 v20, v5

    move-object/from16 v5, v19

    invoke-direct/range {v0 .. v5}, Lcom/twntool/editor/core/CloneEngine;->cloneXmlBlockRaw(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "out":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .local v2, "ok":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 201
    .local v0, "msg":Ljava/lang/String;
    move-object/from16 v16, v1

    .line 202
    if-eqz v2, :cond_108

    move-object/from16 v5, v20

    goto :goto_109

    :cond_108
    move-object v5, v15

    :goto_109
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v10, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move v4, v9

    move-object/from16 v5, v20

    move-object/from16 v9, p3

    .end local v0  # "msg":Ljava/lang/String;
    .end local v1  # "out":Ljava/lang/String;
    .end local v2  # "ok":Z
    goto :goto_b4

    .line 195
    .end local v17  # "open":Ljava/lang/String;
    .end local v18  # "close":Ljava/lang/String;
    .end local v19  # "lbl":Ljava/lang/String;
    :cond_123
    move v9, v4

    move-object/from16 v20, v5

    move-object/from16 v23, v11

    move-object/from16 v34, v15

    goto/16 :goto_3e5

    .line 204
    .end local v16  # "newXml":Ljava/lang/String;
    .local v0, "newXml":Ljava/lang/String;
    :cond_12c
    move v9, v4

    move-object/from16 v20, v5

    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getCloneCity()Z

    move-result v1

    if-nez v1, :cond_13d

    .line 208
    move-object/from16 v16, p2

    move-object/from16 v23, v11

    move-object/from16 v34, v15

    .end local v0  # "newXml":Ljava/lang/String;
    .restart local v16  # "newXml":Ljava/lang/String;
    goto/16 :goto_3e5

    .line 211
    .end local v16  # "newXml":Ljava/lang/String;
    .restart local v0  # "newXml":Ljava/lang/String;
    :cond_13d
    invoke-direct/range {p0 .. p1}, Lcom/twntool/editor/core/CloneEngine;->positionAfterZoo(Ljava/lang/String;)I

    move-result v1

    .line 212
    .local v1, "srcAfterZoo":I
    invoke-direct {v6, v8}, Lcom/twntool/editor/core/CloneEngine;->positionAfterZoo(Ljava/lang/String;)I

    move-result v2

    .line 214
    .local v2, "tgtAfterZoo":I
    const-string v3, "<TownGround"

    const-string v4, "</TownGround>"

    invoke-direct {v6, v7, v3, v4, v1}, Lcom/twntool/editor/core/CloneEngine;->extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;

    move-result-object v5

    invoke-virtual {v5}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .local v14, "rawSrcTg":Ljava/lang/String;
    invoke-virtual {v5}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Ljava/lang/Number;

    invoke-virtual/range {v16 .. v16}, Ljava/lang/Number;->intValue()I

    move-result v9

    .local v9, "srcTgS":I
    invoke-virtual {v5}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Number;

    invoke-virtual {v5}, Ljava/lang/Number;->intValue()I

    move-result v5

    .line 215
    .local v5, "srcTgE":I
    move-object/from16 v16, v0

    .end local v0  # "newXml":Ljava/lang/String;
    .restart local v16  # "newXml":Ljava/lang/String;
    const-string v0, "e:"

    if-nez v14, :cond_190

    .line 216
    const-string v3, "clone_log_no_tg_donor"

    const/4 v4, 0x0

    new-array v13, v4, [Ljava/lang/Object;

    invoke-direct {v6, v3, v13}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v10, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 217
    new-instance v0, Lcom/twntool/editor/core/CloneEngine$CloneResult;

    invoke-direct {v0, v8, v10, v4}, Lcom/twntool/editor/core/CloneEngine$CloneResult;-><init>(Ljava/lang/String;Ljava/util/List;Z)V

    return-object v0

    .line 219
    :cond_190
    move-object/from16 v21, v14

    .line 221
    .local v21, "srcTg":Ljava/lang/String;
    move/from16 v18, v1

    .end local v1  # "srcAfterZoo":I
    .local v18, "srcAfterZoo":I
    const-string v1, "<Buildings"

    move-object/from16 v19, v14

    .end local v14  # "rawSrcTg":Ljava/lang/String;
    .local v19, "rawSrcTg":Ljava/lang/String;
    const-string v14, "</Buildings>"

    invoke-direct {v6, v7, v1, v14, v9}, Lcom/twntool/editor/core/CloneEngine;->extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v23

    move-object/from16 v33, v23

    check-cast v33, Ljava/lang/String;

    .local v33, "rawSrcBld":Ljava/lang/String;
    invoke-virtual/range {v22 .. v22}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v23

    check-cast v23, Ljava/lang/Number;

    move-object/from16 v34, v15

    invoke-virtual/range {v23 .. v23}, Ljava/lang/Number;->intValue()I

    move-result v15

    .local v15, "srcBldS":I
    invoke-virtual/range {v22 .. v22}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v22

    check-cast v22, Ljava/lang/Number;

    invoke-virtual/range {v22 .. v22}, Ljava/lang/Number;->intValue()I

    move-result v7

    .line 222
    .local v7, "srcBldE":I
    if-nez v33, :cond_1e1

    .line 223
    const-string v1, "clone_log_no_bld_donor"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    invoke-direct {v6, v1, v4}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v10, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 224
    new-instance v0, Lcom/twntool/editor/core/CloneEngine$CloneResult;

    invoke-direct {v0, v8, v10, v3}, Lcom/twntool/editor/core/CloneEngine$CloneResult;-><init>(Ljava/lang/String;Ljava/util/List;Z)V

    return-object v0

    .line 226
    :cond_1e1
    move-object/from16 v27, v33

    .line 227
    .local v27, "srcBld":Ljava/lang/String;
    if-lt v15, v9, :cond_1ea

    if-gt v7, v5, :cond_1ea

    const/16 v22, 0x1

    goto :goto_1ec

    :cond_1ea
    const/16 v22, 0x0

    :goto_1ec
    move/from16 v35, v22

    .line 228
    .local v35, "bldInsideTg":Z
    if-eqz v35, :cond_200

    move/from16 v36, v5

    .end local v5  # "srcTgE":I
    .local v36, "srcTgE":I
    const-string v5, "clone_log_bld_inside"

    move/from16 v37, v7

    move/from16 v38, v9

    const/4 v7, 0x0

    .end local v7  # "srcBldE":I
    .end local v9  # "srcTgS":I
    .local v37, "srcBldE":I
    .local v38, "srcTgS":I
    new-array v9, v7, [Ljava/lang/Object;

    invoke-direct {v6, v5, v9}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    goto :goto_20f

    .end local v36  # "srcTgE":I
    .end local v37  # "srcBldE":I
    .end local v38  # "srcTgS":I
    .restart local v5  # "srcTgE":I
    .restart local v7  # "srcBldE":I
    .restart local v9  # "srcTgS":I
    :cond_200
    move/from16 v36, v5

    move/from16 v37, v7

    move/from16 v38, v9

    const/4 v7, 0x0

    .end local v5  # "srcTgE":I
    .end local v7  # "srcBldE":I
    .end local v9  # "srcTgS":I
    .restart local v36  # "srcTgE":I
    .restart local v37  # "srcBldE":I
    .restart local v38  # "srcTgS":I
    const-string v5, "clone_log_bld_outside"

    new-array v9, v7, [Ljava/lang/Object;

    invoke-direct {v6, v5, v9}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    :goto_20f
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v10, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 230
    move-object v5, v11

    check-cast v5, Ljava/lang/CharSequence;

    if-eqz v5, :cond_231

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_22f

    goto :goto_231

    :cond_22f
    const/4 v5, 0x0

    goto :goto_232

    :cond_231
    :goto_231
    const/4 v5, 0x1

    :goto_232
    if-nez v5, :cond_2dd

    move-object v5, v12

    check-cast v5, Ljava/lang/CharSequence;

    if-eqz v5, :cond_242

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_240

    goto :goto_242

    :cond_240
    const/4 v5, 0x0

    goto :goto_243

    :cond_242
    :goto_242
    const/4 v5, 0x1

    :goto_243
    if-nez v5, :cond_2dd

    invoke-static {v11, v12}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2dd

    .line 231
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "user=\""

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v9, "\""

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v23

    const/16 v25, 0x4

    const/16 v26, 0x0

    const/16 v24, 0x0

    invoke-static/range {v21 .. v26}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 232
    .end local v21  # "srcTg":Ljava/lang/String;
    .local v5, "srcTg":Ljava/lang/String;
    move-object/from16 v21, v5

    .end local v5  # "srcTg":Ljava/lang/String;
    .restart local v21  # "srcTg":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v28

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v29

    const/16 v31, 0x4

    const/16 v32, 0x0

    const/16 v30, 0x0

    invoke-static/range {v27 .. v32}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 233
    .end local v27  # "srcBld":Ljava/lang/String;
    .local v5, "srcBld":Ljava/lang/String;
    const-string v7, "clone_log_user_fixed"

    move-object/from16 v22, v5

    const/4 v9, 0x0

    .end local v5  # "srcBld":Ljava/lang/String;
    .local v22, "srcBld":Ljava/lang/String;
    new-array v5, v9, [Ljava/lang/Object;

    invoke-direct {v6, v7, v5}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v10, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v5, v21

    move-object/from16 v7, v22

    goto :goto_2e1

    .line 236
    .end local v22  # "srcBld":Ljava/lang/String;
    .restart local v27  # "srcBld":Ljava/lang/String;
    :cond_2dd
    move-object/from16 v5, v21

    move-object/from16 v7, v27

    .end local v21  # "srcTg":Ljava/lang/String;
    .end local v27  # "srcBld":Ljava/lang/String;
    .local v5, "srcTg":Ljava/lang/String;
    .local v7, "srcBld":Ljava/lang/String;
    :goto_2e1
    invoke-direct {v6, v8, v3, v4, v2}, Lcom/twntool/editor/core/CloneEngine;->extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;

    move-result-object v3

    invoke-virtual {v3}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .local v4, "rawTgtTg":Ljava/lang/String;
    invoke-virtual {v3}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Number;

    invoke-virtual {v9}, Ljava/lang/Number;->intValue()I

    move-result v9

    .local v9, "tgtTgS":I
    invoke-virtual {v3}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Number;

    invoke-virtual {v3}, Ljava/lang/Number;->intValue()I

    move-result v3

    .line 237
    .local v3, "tgtTgE":I
    if-nez v4, :cond_324

    .line 238
    const-string v1, "clone_log_no_tg_target"

    const/4 v13, 0x0

    new-array v14, v13, [Ljava/lang/Object;

    invoke-direct {v6, v1, v14}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v10, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 239
    new-instance v0, Lcom/twntool/editor/core/CloneEngine$CloneResult;

    invoke-direct {v0, v8, v10, v13}, Lcom/twntool/editor/core/CloneEngine$CloneResult;-><init>(Ljava/lang/String;Ljava/util/List;Z)V

    return-object v0

    .line 242
    :cond_324
    const/4 v0, 0x0

    const-string v0, "substring(...)"

    if-eqz v35, :cond_355

    .line 243
    const/4 v1, 0x0

    invoke-virtual {v8, v1, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v8, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move/from16 v22, v2

    move-object/from16 v21, v4

    move-object/from16 v23, v11

    goto/16 :goto_3e3

    .line 245
    :cond_355
    invoke-direct {v6, v8, v1, v14, v3}, Lcom/twntool/editor/core/CloneEngine;->extractBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .local v14, "rawTgtBld":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Ljava/lang/Number;

    move/from16 v22, v2

    .end local v2  # "tgtAfterZoo":I
    .local v22, "tgtAfterZoo":I
    invoke-virtual/range {v21 .. v21}, Ljava/lang/Number;->intValue()I

    move-result v2

    .local v2, "tgtBldS":I
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v1

    .line 246
    .local v1, "tgtBldE":I
    if-nez v14, :cond_3aa

    .line 247
    move-object/from16 v21, v4

    move-object/from16 v23, v11

    const/4 v4, 0x0

    .end local v4  # "rawTgtTg":Ljava/lang/String;
    .end local v11  # "tgtUser":Ljava/lang/String;
    .local v21, "rawTgtTg":Ljava/lang/String;
    .local v23, "tgtUser":Ljava/lang/String;
    invoke-virtual {v8, v4, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v8, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v11, "\n"

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_3e3

    .line 249
    .end local v21  # "rawTgtTg":Ljava/lang/String;
    .end local v23  # "tgtUser":Ljava/lang/String;
    .restart local v4  # "rawTgtTg":Ljava/lang/String;
    .restart local v11  # "tgtUser":Ljava/lang/String;
    :cond_3aa
    move-object/from16 v21, v4

    move-object/from16 v23, v11

    .end local v4  # "rawTgtTg":Ljava/lang/String;
    .end local v11  # "tgtUser":Ljava/lang/String;
    .restart local v21  # "rawTgtTg":Ljava/lang/String;
    .restart local v23  # "tgtUser":Ljava/lang/String;
    const/4 v4, 0x0

    invoke-virtual {v8, v4, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v8, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move/from16 v24, v2

    .end local v2  # "tgtBldS":I
    .local v24, "tgtBldS":I
    invoke-virtual {v8, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 242
    .end local v1  # "tgtBldE":I
    .end local v14  # "rawTgtBld":Ljava/lang/String;
    .end local v24  # "tgtBldS":I
    :goto_3e3
    move-object/from16 v16, v0

    .line 258
    .end local v3  # "tgtTgE":I
    .end local v5  # "srcTg":Ljava/lang/String;
    .end local v7  # "srcBld":Ljava/lang/String;
    .end local v9  # "tgtTgS":I
    .end local v15  # "srcBldS":I
    .end local v18  # "srcAfterZoo":I
    .end local v19  # "rawSrcTg":Ljava/lang/String;
    .end local v21  # "rawTgtTg":Ljava/lang/String;
    .end local v22  # "tgtAfterZoo":I
    .end local v33  # "rawSrcBld":Ljava/lang/String;
    .end local v35  # "bldInsideTg":Z
    .end local v36  # "srcTgE":I
    .end local v37  # "srcBldE":I
    .end local v38  # "srcTgS":I
    :goto_3e5
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getCloneStats()Z

    move-result v0

    if-eqz v0, :cond_4c3

    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getCloneZoo()Z

    move-result v0

    if-nez v0, :cond_4c3

    .line 259
    const-string v0, "clone_log_cloning_stats"

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-direct {v6, v0, v2}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v10, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 260
    sget-object v0, Lcom/twntool/editor/data/FieldMap;->INSTANCE:Lcom/twntool/editor/data/FieldMap;

    invoke-virtual {v0}, Lcom/twntool/editor/data/FieldMap;->getKeys()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_418
    :goto_418
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4a1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 261
    .local v1, "key":Ljava/lang/String;
    const-string v2, "lvl"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_49d

    .line 262
    sget-object v2, Lcom/twntool/editor/data/FieldMap;->INSTANCE:Lcom/twntool/editor/data/FieldMap;

    invoke-virtual {v2}, Lcom/twntool/editor/data/FieldMap;->getMap()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    check-cast v2, Lcom/twntool/editor/data/FieldDef;

    .line 263
    .local v2, "fieldDef":Lcom/twntool/editor/data/FieldDef;
    const/4 v3, 0x0

    .line 264
    .local v3, "srcVal":Ljava/lang/String;
    invoke-virtual {v2}, Lcom/twntool/editor/data/FieldDef;->getXmlKeys()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_444
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_45d

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 265
    .local v5, "xmlKey":Ljava/lang/String;
    sget-object v7, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    move-object/from16 v9, p1

    invoke-virtual {v7, v9, v5}, Lcom/twntool/editor/core/XmlProcessor;->findValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 266
    .local v7, "v":Ljava/lang/String;
    if-eqz v7, :cond_45c

    move-object v3, v7

    goto :goto_45f

    .end local v5  # "xmlKey":Ljava/lang/String;
    .end local v7  # "v":Ljava/lang/String;
    :cond_45c
    goto :goto_444

    .line 264
    :cond_45d
    move-object/from16 v9, p1

    .line 268
    :goto_45f
    if-eqz v3, :cond_418

    .line 269
    invoke-virtual {v2}, Lcom/twntool/editor/data/FieldDef;->getXmlKeys()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move-object/from16 v5, v16

    .end local v16  # "newXml":Ljava/lang/String;
    .local v5, "newXml":Ljava/lang/String;
    :goto_46b
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_499

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 270
    .local v7, "xmlKey":Ljava/lang/String;
    sget-object v11, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v11, v5, v7, v3}, Lcom/twntool/editor/core/XmlProcessor;->replaceValue(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v11

    invoke-virtual {v11}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    .local v13, "out":Ljava/lang/String;
    invoke-virtual {v11}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Boolean;

    invoke-virtual {v11}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v11

    .line 271
    .local v11, "ok":Z
    if-eqz v11, :cond_491

    move-object v14, v13

    goto :goto_497

    :cond_491
    sget-object v14, Lcom/twntool/editor/core/XmlProcessor;->INSTANCE:Lcom/twntool/editor/core/XmlProcessor;

    invoke-virtual {v14, v5, v7, v3}, Lcom/twntool/editor/core/XmlProcessor;->insertVar(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    :goto_497
    move-object v5, v14

    .end local v7  # "xmlKey":Ljava/lang/String;
    .end local v11  # "ok":Z
    .end local v13  # "out":Ljava/lang/String;
    goto :goto_46b

    .line 269
    :cond_499
    move-object/from16 v16, v5

    goto/16 :goto_418

    .line 261
    .end local v2  # "fieldDef":Lcom/twntool/editor/data/FieldDef;
    .end local v3  # "srcVal":Ljava/lang/String;
    .end local v5  # "newXml":Ljava/lang/String;
    .restart local v16  # "newXml":Ljava/lang/String;
    :cond_49d
    move-object/from16 v9, p1

    goto/16 :goto_418

    .line 274
    .end local v1  # "key":Ljava/lang/String;
    :cond_4a1
    move-object/from16 v9, p1

    const-string v0, "clone_log_stats_done"

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-direct {v6, v0, v2}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v7, v20

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v10, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_4c7

    .line 258
    :cond_4c3
    move-object/from16 v9, p1

    move-object/from16 v7, v20

    .line 278
    :goto_4c7
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getSkins()Z

    move-result v0

    if-eqz v0, :cond_520

    .line 279
    const-string v4, "</Skins>"

    const-string v5, "clone_lbl_skins"

    const-string v3, "<Skins"

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v16

    invoke-direct/range {v0 .. v5}, Lcom/twntool/editor/core/CloneEngine;->cloneXmlBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .local v1, "out":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .local v2, "ok":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 280
    .local v0, "msg":Ljava/lang/String;
    move-object/from16 v16, v1

    new-instance v3, Ljava/lang/StringBuilder;

    if-eqz v2, :cond_50b

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v11, v34

    goto :goto_51c

    :cond_50b
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v11, v34

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_51c
    invoke-interface {v10, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .end local v0  # "msg":Ljava/lang/String;
    .end local v1  # "out":Ljava/lang/String;
    .end local v2  # "ok":Z
    goto :goto_522

    .line 278
    :cond_520
    move-object/from16 v11, v34

    .line 282
    :goto_522
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getDecor()Z

    move-result v0

    if-eqz v0, :cond_56e

    .line 283
    const-string v4, "</BuildingsStash>"

    const-string v5, "clone_lbl_decor"

    const-string v3, "<BuildingsStash"

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v16

    invoke-direct/range {v0 .. v5}, Lcom/twntool/editor/core/CloneEngine;->cloneXmlBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .restart local v1  # "out":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .restart local v2  # "ok":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 284
    .restart local v0  # "msg":Ljava/lang/String;
    move-object/from16 v16, v1

    new-instance v3, Ljava/lang/StringBuilder;

    if-eqz v2, :cond_55c

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    goto :goto_563

    :cond_55c
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    :goto_563
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v10, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 286
    .end local v0  # "msg":Ljava/lang/String;
    .end local v1  # "out":Ljava/lang/String;
    .end local v2  # "ok":Z
    :cond_56e
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getStickers()Z

    move-result v0

    if-eqz v0, :cond_5bd

    .line 287
    const-string v4, "</FragmentedBeautyManager>"

    const-string v5, "clone_lbl_stickers"

    const-string v3, "<FragmentedBeautyManager"

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v16

    invoke-direct/range {v0 .. v5}, Lcom/twntool/editor/core/CloneEngine;->cloneXmlBlock(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .restart local v1  # "out":Ljava/lang/String;
    invoke-virtual {v0}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .restart local v2  # "ok":Z
    invoke-virtual {v0}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 288
    .restart local v0  # "msg":Ljava/lang/String;
    move-object/from16 v16, v1

    new-instance v3, Ljava/lang/StringBuilder;

    if-eqz v2, :cond_5a8

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    goto :goto_5af

    :cond_5a8
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    :goto_5af
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v10, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v0, v16

    .end local v0  # "msg":Ljava/lang/String;
    .end local v1  # "out":Ljava/lang/String;
    .end local v2  # "ok":Z
    goto :goto_5bf

    .line 286
    :cond_5bd
    move-object/from16 v0, v16

    .line 290
    .end local v16  # "newXml":Ljava/lang/String;
    .local v0, "newXml":Ljava/lang/String;
    :goto_5bf
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getBadges()Z

    move-result v1

    if-eqz v1, :cond_602

    .line 291
    const-string v1, "UnlockedBadges"

    const-string v2, "clone_lbl_badges"

    invoke-direct {v6, v9, v0, v1, v2}, Lcom/twntool/editor/core/CloneEngine;->cloneDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .local v2, "out":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .local v3, "ok":Z
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 292
    .local v1, "msg":Ljava/lang/String;
    move-object v0, v2

    new-instance v4, Ljava/lang/StringBuilder;

    if-eqz v3, :cond_5f0

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    goto :goto_5f7

    :cond_5f0
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    :goto_5f7
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v10, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 294
    .end local v1  # "msg":Ljava/lang/String;
    .end local v2  # "out":Ljava/lang/String;
    .end local v3  # "ok":Z
    :cond_602
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getTitulos()Z

    move-result v1

    if-eqz v1, :cond_645

    .line 295
    const-string v1, "UnlockedExpRanks"

    const-string v2, "clone_lbl_titles"

    invoke-direct {v6, v9, v0, v1, v2}, Lcom/twntool/editor/core/CloneEngine;->cloneDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .restart local v2  # "out":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .restart local v3  # "ok":Z
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 296
    .restart local v1  # "msg":Ljava/lang/String;
    move-object v0, v2

    new-instance v4, Ljava/lang/StringBuilder;

    if-eqz v3, :cond_633

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    goto :goto_63a

    :cond_633
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    :goto_63a
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v10, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 298
    .end local v1  # "msg":Ljava/lang/String;
    .end local v2  # "out":Ljava/lang/String;
    .end local v3  # "ok":Z
    :cond_645
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getMolduras()Z

    move-result v1

    if-eqz v1, :cond_688

    .line 299
    const-string v1, "UnlockedFrames"

    const-string v2, "clone_lbl_frames"

    invoke-direct {v6, v9, v0, v1, v2}, Lcom/twntool/editor/core/CloneEngine;->cloneDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .restart local v2  # "out":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .restart local v3  # "ok":Z
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 300
    .restart local v1  # "msg":Ljava/lang/String;
    move-object v0, v2

    new-instance v4, Ljava/lang/StringBuilder;

    if-eqz v3, :cond_676

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    goto :goto_67d

    :cond_676
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    :goto_67d
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v10, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 302
    .end local v1  # "msg":Ljava/lang/String;
    .end local v2  # "out":Ljava/lang/String;
    .end local v3  # "ok":Z
    :cond_688
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getEstilos()Z

    move-result v1

    if-eqz v1, :cond_6cb

    .line 303
    const-string v1, "UnlockedStyles"

    const-string v2, "clone_lbl_styles"

    invoke-direct {v6, v9, v0, v1, v2}, Lcom/twntool/editor/core/CloneEngine;->cloneDataElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlin/Triple;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Triple;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .restart local v2  # "out":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Triple;->component2()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .restart local v3  # "ok":Z
    invoke-virtual {v1}, Lkotlin/Triple;->component3()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 304
    .restart local v1  # "msg":Ljava/lang/String;
    move-object v0, v2

    new-instance v4, Ljava/lang/StringBuilder;

    if-eqz v3, :cond_6b9

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    goto :goto_6c0

    :cond_6b9
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    :goto_6c0
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v10, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 306
    .end local v1  # "msg":Ljava/lang/String;
    .end local v2  # "out":Ljava/lang/String;
    .end local v3  # "ok":Z
    :cond_6cb
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getAvatares()Z

    move-result v1

    if-eqz v1, :cond_6f6

    .line 307
    invoke-direct {v6, v9, v0}, Lcom/twntool/editor/core/CloneEngine;->cloneAvatars(Ljava/lang/String;Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .restart local v2  # "out":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 308
    .restart local v1  # "msg":Ljava/lang/String;
    move-object v0, v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v10, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 316
    .end local v1  # "msg":Ljava/lang/String;
    .end local v2  # "out":Ljava/lang/String;
    :cond_6f6
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getCloneZoo()Z

    move-result v1

    if-nez v1, :cond_73b

    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getCloneCity()Z

    move-result v1

    if-eqz v1, :cond_73b

    .line 317
    invoke-virtual {v6, v0}, Lcom/twntool/editor/core/CloneEngine;->fecharQuestsTutorialInicial(Ljava/lang/String;)Lkotlin/Pair;

    move-result-object v1

    invoke-virtual {v1}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .local v2, "fixed":Ljava/lang/String;
    invoke-virtual {v1}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v1

    .line 318
    .local v1, "nFix":I
    move-object v0, v2

    .line 319
    if-lez v1, :cond_73b

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "clone_log_tut_skip"

    invoke-direct {v6, v4, v3}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v10, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 322
    .end local v1  # "nFix":I
    .end local v2  # "fixed":Ljava/lang/String;
    :cond_73b
    invoke-virtual/range {p3 .. p3}, Lcom/twntool/editor/core/CloneEngine$CloneOptions;->getCloneZoo()Z

    move-result v1

    if-eqz v1, :cond_744

    const-string v1, "clone_log_zoo_done"

    goto :goto_746

    :cond_744
    const-string v1, "clone_log_done"

    .line 323
    .local v1, "doneKey":Ljava/lang/String;
    :goto_746
    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v6, v1, v2}, Lcom/twntool/editor/core/CloneEngine;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v10, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 324
    new-instance v2, Lcom/twntool/editor/core/CloneEngine$CloneResult;

    const/4 v3, 0x1

    invoke-direct {v2, v0, v10, v3}, Lcom/twntool/editor/core/CloneEngine$CloneResult;-><init>(Ljava/lang/String;Ljava/util/List;Z)V

    return-object v2
.end method

.method public final fecharQuestsTutorialInicial(Ljava/lang/String;)Lkotlin/Pair;
    .registers 33
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

    const-string v0, "xml"

    move-object/from16 v1, p1

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 335
    const/4 v0, 0x4

    new-array v2, v0, [Ljava/lang/String;

    const-string v3, "common_1"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-string v3, "special_1"

    const/4 v5, 0x1

    aput-object v3, v2, v5

    const-string v3, "special_2"

    const/4 v6, 0x2

    aput-object v3, v2, v6

    const-string v3, "special_3"

    const/4 v7, 0x3

    aput-object v3, v2, v7

    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    .line 338
    .local v2, "QUESTS_INICIAIS":Ljava/util/List;
    const/16 v3, 0xb

    new-array v8, v3, [Lkotlin/Pair;

    const-string v9, "M3a"

    const-string v10, "1"

    invoke-static {v9, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    aput-object v9, v8, v4

    const-string v9, "M3b"

    invoke-static {v9, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    aput-object v9, v8, v5

    const-string v9, "M3c"

    invoke-static {v9, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    aput-object v9, v8, v6

    .line 339
    const-string v9, "M3d"

    const-string v11, "true"

    invoke-static {v9, v11}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v9

    aput-object v9, v8, v7

    .line 338
    nop

    .line 340
    const-string v7, "cityhall achievement"

    invoke-static {v7, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v7

    aput-object v7, v8, v0

    .line 338
    nop

    .line 341
    const-string v0, "complete community building"

    invoke-static {v0, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    const/4 v7, 0x5

    aput-object v0, v8, v7

    .line 338
    nop

    .line 342
    const-string v0, "order helicopterclose citymap helicopter"

    invoke-static {v0, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    const/4 v7, 0x6

    aput-object v0, v8, v7

    .line 338
    nop

    .line 343
    const-string v0, "order helicopter"

    invoke-static {v0, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    const/4 v7, 0x7

    aput-object v0, v8, v7

    .line 338
    nop

    .line 344
    const-string v0, "send train help"

    invoke-static {v0, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    const/16 v7, 0x8

    aput-object v0, v8, v7

    .line 338
    nop

    .line 345
    const-string v0, "market sell"

    invoke-static {v0, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    const/16 v7, 0x9

    aput-object v0, v8, v7

    .line 338
    nop

    .line 346
    const-string v0, "level up inc"

    invoke-static {v0, v10}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    const/16 v7, 0xa

    aput-object v0, v8, v7

    .line 338
    nop

    .line 337
    invoke-static {v8}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    .line 348
    .local v0, "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    move-object/from16 v7, p1

    .line 349
    .local v7, "out":Ljava/lang/String;
    const/4 v8, 0x0

    .line 351
    .local v8, "nFechadas":I
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_9e
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_334

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .line 352
    .local v10, "questName":Ljava/lang/String;
    new-instance v12, Lkotlin/text/Regex;

    sget-object v13, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v13, v10}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "<DataElem\\s+name=\""

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\"\\s+type=\"dataStore\">"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v12, v13}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 354
    .local v12, "openPat":Lkotlin/text/Regex;
    move-object v13, v7

    check-cast v13, Ljava/lang/CharSequence;

    const/4 v14, 0x0

    invoke-static {v12, v13, v4, v6, v14}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v13

    if-nez v13, :cond_e3

    move-object/from16 v23, v0

    move-object/from16 v17, v2

    move v1, v4

    move/from16 v21, v5

    move-object/from16 v19, v9

    goto/16 :goto_324

    .line 357
    .local v13, "mOpen":Lkotlin/text/MatchResult;
    :cond_e3
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v15

    invoke-virtual {v15}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v15

    add-int/2addr v15, v5

    .line 358
    .local v15, "pos":I
    const/16 v16, 0x1

    .line 359
    .local v16, "depth":I
    const/16 v17, -0x1

    .line 360
    .local v17, "endPos":I
    :goto_f0
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v5, -0x1

    if-ge v15, v3, :cond_15d

    if-lez v16, :cond_15d

    .line 361
    move-object/from16 v18, v7

    check-cast v18, Ljava/lang/CharSequence;

    const/16 v22, 0x4

    const/16 v23, 0x0

    const-string v19, "<DataElem"

    const/16 v21, 0x0

    move/from16 v20, v15

    invoke-static/range {v18 .. v23}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v3

    .line 362
    .local v3, "op":I
    move-object/from16 v18, v7

    check-cast v18, Ljava/lang/CharSequence;

    const-string v19, "</DataElem>"

    invoke-static/range {v18 .. v23}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v4

    .line 363
    .local v4, "cl":I
    if-eq v4, v5, :cond_15d

    .line 364
    if-eq v3, v5, :cond_14b

    if-ge v3, v4, :cond_14b

    .line 365
    move-object/from16 v25, v7

    check-cast v25, Ljava/lang/CharSequence;

    const/16 v29, 0x4

    const/16 v30, 0x0

    const/16 v26, 0x3e

    const/16 v28, 0x0

    move/from16 v27, v3

    invoke-static/range {v25 .. v30}, Lkotlin/text/StringsKt;->indexOf$default(Ljava/lang/CharSequence;CIZILjava/lang/Object;)I

    move-result v6

    .line 366
    .local v6, "eot":I
    if-eq v6, v5, :cond_13b

    add-int/lit8 v14, v6, -0x1

    invoke-virtual {v7, v14}, Ljava/lang/String;->charAt(I)C

    move-result v14

    const/16 v5, 0x2f

    if-eq v14, v5, :cond_13b

    add-int/lit8 v16, v16, 0x1

    .line 367
    :cond_13b
    const/4 v5, -0x1

    if-eq v6, v5, :cond_141

    add-int/lit8 v5, v6, 0x1

    goto :goto_143

    :cond_141
    add-int/lit8 v5, v3, 0x1

    :goto_143
    move v15, v5

    const/16 v3, 0xb

    const/4 v4, 0x0

    const/4 v5, 0x1

    const/4 v6, 0x2

    const/4 v14, 0x0

    .end local v6  # "eot":I
    goto :goto_f0

    .line 369
    :cond_14b
    add-int/lit8 v16, v16, -0x1

    .line 370
    if-nez v16, :cond_154

    add-int/lit8 v17, v4, 0xb

    move/from16 v3, v17

    goto :goto_15f

    .line 371
    :cond_154
    add-int/lit8 v15, v4, 0xb

    const/16 v3, 0xb

    const/4 v4, 0x0

    const/4 v5, 0x1

    const/4 v6, 0x2

    const/4 v14, 0x0

    .end local v3  # "op":I
    .end local v4  # "cl":I
    goto :goto_f0

    .line 374
    :cond_15d
    move/from16 v3, v17

    .end local v17  # "endPos":I
    .local v3, "endPos":I
    :goto_15f
    const/4 v4, -0x1

    if-eq v3, v4, :cond_319

    .line 376
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v4

    invoke-virtual {v4}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v4

    invoke-virtual {v7, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "substring(...)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 378
    .local v4, "bloco":Ljava/lang/String;
    new-instance v6, Lkotlin/text/Regex;

    const-string v14, "<DataElem\\s+name=\"S\"\\s+type=\"int\"\\s+value=\"4\"\\s*/>"

    invoke-direct {v6, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    move-object v14, v4

    check-cast v14, Ljava/lang/CharSequence;

    invoke-virtual {v6, v14}, Lkotlin/text/Regex;->containsMatchIn(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_30d

    .line 381
    new-instance v6, Lkotlin/text/Regex;

    const-string v14, "(<DataElem\\s+name=\"S\"\\s+type=\"int\"\\s+value=\")\\d+(\")"

    invoke-direct {v6, v14}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 382
    .local v6, "sPattern":Lkotlin/text/Regex;
    move-object v14, v4

    check-cast v14, Ljava/lang/CharSequence;

    move-object/from16 v17, v2

    move-object/from16 v19, v9

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v9, 0x2

    .end local v2  # "QUESTS_INICIAIS":Ljava/util/List;
    .local v17, "QUESTS_INICIAIS":Ljava/util/List;
    invoke-static {v6, v14, v2, v9, v1}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v1

    .line 383
    .local v1, "mS":Lkotlin/text/MatchResult;
    if-eqz v1, :cond_1f5

    .line 384
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v9

    invoke-virtual {v9}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v9

    invoke-virtual {v4, v2, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 385
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v2

    const/4 v14, 0x1

    invoke-interface {v2, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v1}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v14

    move-object/from16 v20, v6

    const/4 v6, 0x2

    .end local v6  # "sPattern":Lkotlin/text/Regex;
    .local v20, "sPattern":Lkotlin/text/Regex;
    invoke-interface {v14, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v14

    .line 386
    invoke-interface {v1}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lkotlin/ranges/IntRange;->getLast()I

    move-result v18

    const/16 v21, 0x1

    add-int/lit8 v6, v18, 0x1

    invoke-virtual {v4, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v18, v1

    .end local v1  # "mS":Lkotlin/text/MatchResult;
    .local v18, "mS":Lkotlin/text/MatchResult;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "4"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    const/16 v1, 0xb

    goto :goto_214

    .line 388
    .end local v18  # "mS":Lkotlin/text/MatchResult;
    .end local v20  # "sPattern":Lkotlin/text/Regex;
    .restart local v1  # "mS":Lkotlin/text/MatchResult;
    .restart local v6  # "sPattern":Lkotlin/text/Regex;
    :cond_1f5
    move-object/from16 v18, v1

    move-object/from16 v20, v6

    const/16 v21, 0x1

    .end local v1  # "mS":Lkotlin/text/MatchResult;
    .end local v6  # "sPattern":Lkotlin/text/Regex;
    .restart local v18  # "mS":Lkotlin/text/MatchResult;
    .restart local v20  # "sPattern":Lkotlin/text/Regex;
    const/16 v1, 0xb

    invoke-static {v4, v1}, Lkotlin/text/StringsKt;->dropLast(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "<DataElem name=\"S\" type=\"int\" value=\"4\"/></DataElem>"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 383
    :goto_214
    nop

    .line 393
    .local v2, "blocoNovo":Ljava/lang/String;
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_21d
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_2c2

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/util/Map$Entry;

    invoke-interface {v9}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .local v14, "counterName":Ljava/lang/String;
    invoke-interface {v9}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 394
    .local v9, "targetVal":Ljava/lang/String;
    invoke-static {v9, v11}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v23

    const-string v1, "(<DataElem\\s+name=\""

    if-eqz v23, :cond_27c

    .line 397
    nop

    .line 395
    move-object/from16 v23, v0

    .end local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .local v23, "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    new-instance v0, Lkotlin/text/Regex;

    move-object/from16 v24, v6

    sget-object v6, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v6, v14}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v25, v10

    .end local v10  # "questName":Ljava/lang/String;
    .local v25, "questName":Ljava/lang/String;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, "\"\\s+type=\"bool\"\\s+value=\")[^\"]*(\")"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 397
    move-object v1, v2

    check-cast v1, Ljava/lang/CharSequence;

    new-instance v6, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda3;

    invoke-direct {v6}, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda3;-><init>()V

    invoke-virtual {v0, v1, v6}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v0

    .line 395
    move-object v2, v0

    move-object/from16 v0, v23

    move-object/from16 v6, v24

    move-object/from16 v10, v25

    const/16 v1, 0xb

    goto :goto_21d

    .line 399
    .end local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v25  # "questName":Ljava/lang/String;
    .restart local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v10  # "questName":Ljava/lang/String;
    :cond_27c
    move-object/from16 v23, v0

    move-object/from16 v24, v6

    move-object/from16 v25, v10

    .end local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v10  # "questName":Ljava/lang/String;
    .restart local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v25  # "questName":Ljava/lang/String;
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 402
    .local v0, "tv":I
    nop

    .line 400
    new-instance v6, Lkotlin/text/Regex;

    sget-object v10, Lkotlin/text/Regex;->Companion:Lkotlin/text/Regex$Companion;

    invoke-virtual {v10, v14}, Lkotlin/text/Regex$Companion;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object/from16 v26, v9

    .end local v9  # "targetVal":Ljava/lang/String;
    .local v26, "targetVal":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v9, "\"\\s+type=\"int\"\\s+value=\")(\\d+)(\")"

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v6, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    .line 402
    move-object v1, v2

    check-cast v1, Ljava/lang/CharSequence;

    new-instance v9, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda4;

    invoke-direct {v9, v0}, Lcom/twntool/editor/core/CloneEngine$$ExternalSyntheticLambda4;-><init>(I)V

    invoke-virtual {v6, v1, v9}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v1

    .line 400
    move-object v2, v1

    move-object/from16 v0, v23

    move-object/from16 v6, v24

    move-object/from16 v10, v25

    const/16 v1, 0xb

    .end local v0  # "tv":I
    .end local v14  # "counterName":Ljava/lang/String;
    .end local v26  # "targetVal":Ljava/lang/String;
    goto/16 :goto_21d

    .line 410
    .end local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v25  # "questName":Ljava/lang/String;
    .local v0, "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v10  # "questName":Ljava/lang/String;
    :cond_2c2
    move-object/from16 v23, v0

    move-object/from16 v25, v10

    .end local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v10  # "questName":Ljava/lang/String;
    .restart local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v25  # "questName":Ljava/lang/String;
    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_30b

    .line 411
    invoke-interface {v13}, Lkotlin/text/MatchResult;->getRange()Lkotlin/ranges/IntRange;

    move-result-object v0

    invoke-virtual {v0}, Lkotlin/ranges/IntRange;->getFirst()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {v7, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v7, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 412
    nop

    .end local v2  # "blocoNovo":Ljava/lang/String;
    .end local v3  # "endPos":I
    .end local v4  # "bloco":Ljava/lang/String;
    .end local v12  # "openPat":Lkotlin/text/Regex;
    .end local v13  # "mOpen":Lkotlin/text/MatchResult;
    .end local v15  # "pos":I
    .end local v16  # "depth":I
    .end local v18  # "mS":Lkotlin/text/MatchResult;
    .end local v20  # "sPattern":Lkotlin/text/Regex;
    .end local v25  # "questName":Ljava/lang/String;
    add-int/lit8 v8, v8, 0x1

    move v4, v1

    move-object/from16 v2, v17

    move-object/from16 v9, v19

    move/from16 v5, v21

    move-object/from16 v0, v23

    const/16 v3, 0xb

    const/4 v6, 0x2

    move-object/from16 v1, p1

    goto/16 :goto_9e

    .line 410
    .restart local v2  # "blocoNovo":Ljava/lang/String;
    .restart local v3  # "endPos":I
    .restart local v4  # "bloco":Ljava/lang/String;
    .restart local v12  # "openPat":Lkotlin/text/Regex;
    .restart local v13  # "mOpen":Lkotlin/text/MatchResult;
    .restart local v15  # "pos":I
    .restart local v16  # "depth":I
    .restart local v18  # "mS":Lkotlin/text/MatchResult;
    .restart local v20  # "sPattern":Lkotlin/text/Regex;
    .restart local v25  # "questName":Ljava/lang/String;
    :cond_30b
    const/4 v1, 0x0

    goto :goto_324

    .line 378
    .end local v17  # "QUESTS_INICIAIS":Ljava/util/List;
    .end local v18  # "mS":Lkotlin/text/MatchResult;
    .end local v20  # "sPattern":Lkotlin/text/Regex;
    .end local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v25  # "questName":Ljava/lang/String;
    .restart local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .local v2, "QUESTS_INICIAIS":Ljava/util/List;
    .restart local v10  # "questName":Ljava/lang/String;
    :cond_30d
    move-object/from16 v23, v0

    move-object/from16 v17, v2

    move-object/from16 v19, v9

    move-object/from16 v25, v10

    const/4 v1, 0x0

    const/16 v21, 0x1

    .end local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v2  # "QUESTS_INICIAIS":Ljava/util/List;
    .end local v10  # "questName":Ljava/lang/String;
    .restart local v17  # "QUESTS_INICIAIS":Ljava/util/List;
    .restart local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v25  # "questName":Ljava/lang/String;
    goto :goto_324

    .line 374
    .end local v4  # "bloco":Ljava/lang/String;
    .end local v17  # "QUESTS_INICIAIS":Ljava/util/List;
    .end local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v25  # "questName":Ljava/lang/String;
    .restart local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v2  # "QUESTS_INICIAIS":Ljava/util/List;
    .restart local v10  # "questName":Ljava/lang/String;
    :cond_319
    move-object/from16 v23, v0

    move-object/from16 v17, v2

    move-object/from16 v19, v9

    move-object/from16 v25, v10

    const/4 v1, 0x0

    const/16 v21, 0x1

    .line 351
    .end local v3  # "endPos":I
    .end local v10  # "questName":Ljava/lang/String;
    .end local v12  # "openPat":Lkotlin/text/Regex;
    .end local v13  # "mOpen":Lkotlin/text/MatchResult;
    .end local v15  # "pos":I
    .end local v16  # "depth":I
    :goto_324
    move v4, v1

    move-object/from16 v2, v17

    move-object/from16 v9, v19

    move/from16 v5, v21

    move-object/from16 v0, v23

    const/16 v3, 0xb

    const/4 v6, 0x2

    move-object/from16 v1, p1

    .end local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .end local v2  # "QUESTS_INICIAIS":Ljava/util/List;
    .restart local v17  # "QUESTS_INICIAIS":Ljava/util/List;
    .restart local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    goto/16 :goto_9e

    .line 415
    .end local v17  # "QUESTS_INICIAIS":Ljava/util/List;
    .end local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v2  # "QUESTS_INICIAIS":Ljava/util/List;
    :cond_334
    move-object/from16 v23, v0

    .end local v0  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    .restart local v23  # "COUNTERS_TO_COMPLETE":Ljava/util/Map;
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v7, v0}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    return-object v0
.end method
