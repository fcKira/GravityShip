public static class FlyweightPointer
{
    public static readonly FlyweightAttractor Asteroid = new FlyweightAttractor
    {
        layerMaskForPlanets = (1 << 8), // | (1<<9)
        layerMaskForShip = (1 << 9),
    };
}
