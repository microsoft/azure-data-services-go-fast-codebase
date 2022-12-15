using System.Collections.ObjectModel;

namespace SecureFileUploader.Portal.Web.Tests.Extensions;

public static class TestExtensions
{
    public static ObservableCollection<T> ToObservableCollection<T>(this IEnumerable<T> enumerable) => new(enumerable);

    public static List<T> ToListOfSelf<T>(this T item) => new() { item };

#pragma warning disable CS1998
    public static async IAsyncEnumerable<T> ToAsyncEnumerable<T>(this IEnumerable<T> enumerable)
#pragma warning restore CS1998
    {
        foreach (var item in enumerable) yield return item;
    }
}
