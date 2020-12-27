using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipModel : Attractor, IGravitySensitive
{
    public float baseSpeed;
    public float boostSpeed;

    ShipController _controller;

    float _totalSpeed;

    Rigidbody2D _rgbd;

    public bool boolean;

    float _boundWidth, _boundHeight;

    void Awake()
    {
        _controller = new ShipController(this, GetComponent<ShipView>());

        _rgbd = GetComponent<Rigidbody2D>();

        _totalSpeed = baseSpeed;

        _rgbd.velocity = transform.right * _totalSpeed;

        _boundHeight = Camera.main.orthographicSize;
        _boundWidth = _boundHeight * Screen.width / Screen.height;

    }

    protected override void FixedUpdate()
    {
        base.FixedUpdate();

        _controller.ControllerFixedUpdate();
        
    }

    void LateUpdate()
    {
        if (transform.position.x > _boundWidth || transform.position.x < -_boundWidth || transform.position.y < -_boundHeight || transform.position.y > _boundHeight)
        {
            UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
        }
        
    }

    public void Movement()
    {
        if (_rgbd.velocity.magnitude < _totalSpeed)
        {
            _rgbd.AddForce(transform.right * _totalSpeed);
        }

        transform.right = _rgbd.velocity.normalized;
    }

    public void StartBoost()
    {
        _totalSpeed += boostSpeed;
    }

    public void StopBoost()
    {
        _totalSpeed -= boostSpeed;
    }

    public void GetExtraForce(float extraForce, Vector3 center)
    {
        Vector3 dir = center - transform.position;
        _rgbd.AddForce(dir.normalized * extraForce);
    }

    protected override void Attract()
    {
        Collider2D[] pickables = Physics2D.OverlapCircleAll(transform.position, attractRadius, FlyweightPointer.Asteroid.layerMaskForShip);

        foreach (var obj in pickables)
        {
            obj.GetComponent<IGravitySensitive>().GetExtraForce(attractForce, transform.position);
        }
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        var pickableObj = collision.GetComponent<Pickable>();
        
        if (pickableObj)
            pickableObj.PickedUp();
        else if (collision.GetComponent<AttractorObj>())
            UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);

    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawWireSphere(transform.position, attractRadius);
    }

}
