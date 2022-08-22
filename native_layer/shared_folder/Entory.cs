using System.Net;
using System.Runtime.InteropServices;

namespace shared_folder;

public class Entory
{
    [UnmanagedCallersOnly(EntryPoint = "numbers")]
    public static int Numbers(int a, int b)
    {
        return a + b;
    }

    [UnmanagedCallersOnly(EntryPoint = "strings")]
    public static IntPtr Strings(IntPtr first, IntPtr second)
    {
        #pragma warning disable CS8600
        string firstString = Marshal.PtrToStringAnsi(first);
        string SecondString = Marshal.PtrToStringAnsi(second);

        string result = $"{firstString} {SecondString}";

        return Marshal.StringToHGlobalAnsi(result);
    }
}
