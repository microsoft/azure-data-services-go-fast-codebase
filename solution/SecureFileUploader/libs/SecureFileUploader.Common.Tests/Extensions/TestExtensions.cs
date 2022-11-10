using System.Collections.ObjectModel;

namespace SecureFileUploader.Common.Tests.Extensions;

public static class TestExtensions
{
    public static ObservableCollection<T> ToObservableCollection<T>(this IEnumerable<T> enumerable) => new(enumerable);

    public static List<T> ToListOfSelf<T>(this T item) => new() { item };
}
