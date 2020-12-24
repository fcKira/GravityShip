public static class FlyweightPointer
{
    public static readonly FlyweightAttractor Asteroid = new FlyweightAttractor
    {
        layerMask = (1<<8), // | (1<<9)
    };
}
